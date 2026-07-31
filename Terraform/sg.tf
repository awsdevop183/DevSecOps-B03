resource "aws_security_group" "terraform-sg" {
  name        = "terraform-sg"
  description = "Testing Terraform"
  vpc_id      = aws_vpc.terraform-vpc.id

  tags = {
    Name = "Terraform-SG"
  }
  lifecycle {
    # ignore_changes = [
    #   tags,
    #   ingress
    # ]

    ignore_changes = all

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["49.43.228.119/32"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["49.43.228.119/32"]
  }



}


# data "http" "myip" {
#   url = "https://ifconfig.me/ip"
# }
