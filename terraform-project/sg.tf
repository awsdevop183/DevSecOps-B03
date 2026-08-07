resource "aws_security_group" "terraform-sg" {
  name        = "Terraform-SG"
  description = "Allow traffic from internet"
  vpc_id      = aws_vpc.prod-vpc.id

  tags = {
    Name = "Terraform-SG"
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
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.response_body)}/32"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "http" "my_ip" {
  url = "https://ipv4.icanhazip.com"
}
