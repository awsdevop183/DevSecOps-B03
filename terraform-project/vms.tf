resource "aws_instance" "test-vm" {
  ami           = var.ami
  key_name      = "MacbookAir"
  instance_type = "t3.micro"

  tags = {
    Name = "Terraform-VM"
  }
  subnet_id = aws_subnet.public-subnets[0].id
  # security_groups = [aws_security_group.terraform-sg.id]
  vpc_security_group_ids = [aws_security_group.terraform-sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl status nginx
              EOF

}
