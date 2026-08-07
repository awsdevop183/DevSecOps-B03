locals {
  ingress = [22, 80, 443, 8080]
}



resource "aws_security_group" "terraform-sg" {
  name        = var.sg-name
  description = "Testing Terraform"
  vpc_id      = aws_vpc.terraform-vpc.id

  tags = {
    Name = "${var.sg-name}-SG"
  }
  lifecycle {
    # ignore_changes = [
    #   tags,
    #   ingress
    # ]

    ignore_changes = all

  }
  dynamic "ingress" {
    for_each = local.ingress
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]

    }

  }

  # ingress {
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "TCP"
  #   cidr_blocks = ["49.43.228.119/32"]
  # }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}


# data "http" "myip" {
#   url = "https://ifconfig.me/ip"
# }


