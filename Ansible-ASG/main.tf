### Networking - reuse the account's default VPC to keep the demo lightweight

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# ALB needs subnets in at least 2 distinct AZs
data "aws_subnet" "available" {
  for_each = toset(data.aws_subnets.default.ids)
  id       = each.value
}

locals {
  az_to_subnet = { for s in data.aws_subnet.available : s.availability_zone => s.id... }
  alb_subnets  = [for az, ids in local.az_to_subnet : ids[0]]
  name_suffix  = random_id.suffix.hex
}

resource "random_id" "suffix" {
  byte_length = 3
}

### AMI - Ubuntu 22.04 LTS (Canonical)

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

### SSH key pair - existing "ansible" key pair already registered in this account/region

data "aws_key_pair" "existing" {
  key_name           = var.key_name
  include_public_key = true
}

### Security groups

resource "aws_security_group" "alb" {
  name        = "${var.project_name}-alb-${local.name_suffix}"
  description = "Allow inbound HTTP to the ALB"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-alb-sg"
    Project = var.project_name
  }
}

resource "aws_security_group" "controller" {
  name        = "${var.project_name}-controller-${local.name_suffix}"
  description = "Ansible controller - SSH admin access in, outbound to nodes/internet"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH admin access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-controller-sg"
    Project = var.project_name
  }
}

resource "aws_security_group" "node" {
  name        = "${var.project_name}-node-${local.name_suffix}"
  description = "Allow HTTP from the ALB and SSH from the controller/admin"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    description     = "SSH from the Ansible controller"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.controller.id]
  }

  ingress {
    description = "SSH for direct/admin access (e.g. from your MacBook Air)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-node-sg"
    Project = var.project_name
  }
}

### IAM role for the controller - read-only EC2 access so the aws_ec2 dynamic
### inventory plugin can query instances without static AWS credentials

data "aws_iam_policy_document" "controller_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "controller" {
  name               = "${var.project_name}-controller-${local.name_suffix}"
  assume_role_policy = data.aws_iam_policy_document.controller_assume.json

  tags = {
    Project = var.project_name
  }
}

resource "aws_iam_role_policy_attachment" "controller_ec2_readonly" {
  role       = aws_iam_role.controller.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "controller" {
  name = "${var.project_name}-controller-${local.name_suffix}"
  role = aws_iam_role.controller.name
}

### Ansible controller - EC2 instance with Ansible + amazon.aws pre-installed.
### Uses the same "ansible" key pair as the nodes, so once you copy the
### matching private key onto it, it can SSH straight into the ASG nodes.

resource "aws_instance" "controller" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.controller_instance_type
  key_name               = "MacbookAir"
  subnet_id              = local.alb_subnets[0]
  vpc_security_group_ids = [aws_security_group.controller.id]
  iam_instance_profile   = aws_iam_instance_profile.controller.name

  user_data = file("${path.module}/controller_userdata.sh.tpl")

  tags = {
    Name    = "${var.project_name}-controller"
    Project = var.project_name
    Role    = "ansible-controller"
  }
}

### Launch template + Auto Scaling Group

resource "aws_launch_template" "node" {
  name_prefix   = "${var.project_name}-lt-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.node_instance_type
  key_name      = data.aws_key_pair.existing.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.node.id]
  }

  user_data = base64encode(templatefile("${path.module}/userdata.sh.tpl", {
    project_name = var.project_name
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.project_name}-node"
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "ansible-dynamic-inventory"
    }
  }

  tags = {
    Name = "${var.project_name}-lt"
  }
}

resource "aws_autoscaling_group" "node" {
  name                = "${var.project_name}-asg-${local.name_suffix}"
  desired_capacity    = var.asg_desired_capacity
  min_size            = var.asg_min_size
  max_size            = var.asg_max_size
  vpc_zone_identifier = local.alb_subnets

  launch_template {
    id      = aws_launch_template.node.id
    version = "$Latest"
  }

  target_group_arns         = [aws_lb_target_group.node.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 90

  tag {
    key                 = "Name"
    value               = "${var.project_name}-node"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_name
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }
}

### Application Load Balancer

resource "aws_lb" "node" {
  name               = "${var.project_name}-alb-${local.name_suffix}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = local.alb_subnets

  tags = {
    Name    = "${var.project_name}-alb"
    Project = var.project_name
  }
}

resource "aws_lb_target_group" "node" {
  name     = "${var.project_name}-tg-${local.name_suffix}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    interval            = 15
    timeout             = 5
  }

  tags = {
    Project = var.project_name
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.node.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.node.arn
  }
}
