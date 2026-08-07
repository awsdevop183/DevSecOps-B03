resource "aws_security_group" "controller-sg" {
  name        = "${var.vpc-name}-controller-sg"
  description = "Ansible controller - SSH from admin"
  vpc_id      = aws_vpc.ansible-vpc.id

  tags = {
    Name = "${var.vpc-name}-controller-sg"
  }

  ingress {
    description = "SSH from admin"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [var.ssh_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_security_group" "node-sg" {
  name        = "${var.vpc-name}-node-sg"
  description = "Managed nodes - SSH from controller, HTTP for demos"
  vpc_id      = aws_vpc.ansible-vpc.id

  tags = {
    Name = "${var.vpc-name}-node-sg"
  }

  ingress {
    description     = "SSH from the Ansible controller"
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [aws_security_group.controller-sg.id]
  }

  ingress {
    description = "SSH from admin"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [var.ssh_cidr]
  }

  # Handy for "install nginx with Ansible" style demos
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}
