data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

locals {
  subnet_keys = keys(var.public-subnets)
}

resource "aws_instance" "controller" {
  # ami                         = data.aws_ami.ubuntu.id
  ami                         = var.ami
  instance_type               = var.controller_instance_type
  key_name                    = var.controller_key
  subnet_id                   = aws_subnet.public-subnets[local.subnet_keys[0]].id
  vpc_security_group_ids      = [aws_security_group.controller-sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  user_data = <<-EOF
#!/bin/bash
set -e
apt-get update -y
apt-get install -y software-properties-common git
add-apt-repository --yes --update ppa:ansible/ansible
apt-get install -y ansible
cd /home/ubuntu
git clone https://github.com/awsdevop183/DevSecOps-B03.git
cat > /home/ubuntu/DevSecOps-B03/Ansible/ansible.pem <<'KEY'
${file("${path.module}/../Ansible/ansible.pem")}
KEY

chmod 600 /home/ubuntu/DevSecOps-B03/Ansible/ansible.pem
chown ubuntu:ubuntu /home/ubuntu/DevSecOps-B03/Ansible/ansible.pem

EOF

  tags = {
    Name = "${var.vpc-name}-controller"
    Role = "controller"
  }

}

resource "aws_instance" "node" {
  count = var.node_count
  # ami                         = data.aws_ami.ubuntu.id
  ami                         = var.ami
  instance_type               = var.node_instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.public-subnets[local.subnet_keys[count.index % length(local.subnet_keys)]].id
  vpc_security_group_ids      = [aws_security_group.node-sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "node-${count.index + 1}"
    Role = "node"
  }

}

# resource "aws_instance" "amazon-linux" {
#   ami                         = var.amzon-linux-ami
#   instance_type               = var.node_instance_type
#   key_name                    = var.key_name
#   subnet_id                   = aws_subnet.public-subnets["subnet-1"].id
#   vpc_security_group_ids      = [aws_security_group.node-sg.id]
#   associate_public_ip_address = true

#   tags = {
#     Name = "centos"
#     Role = "node"
#   }

# }
