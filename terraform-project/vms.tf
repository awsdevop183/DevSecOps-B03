resource "aws_instance" "test-vm" {

  # count         = 2
  count = var.environment == "development" || var.environment == "DEVELOPMENT" ? 2 : 1

  ami           = var.ami
  key_name      = "MacbookAir"
  instance_type = "t3.micro"

  tags = {
    Name = "Terraform-VM-${count.index + 1}"
  }
  subnet_id              = aws_subnet.public-subnets[0].id
  vpc_security_group_ids = [aws_security_group.terraform-sg.id]

  # provisioner "file" {
  #   source      = "./test.sh"
  #   destination = "/tmp"
  # }

  # connection {
  #   type        = "ssh"
  #   user        = "ubuntu"
  #   host        = self.public_ip
  #   private_key = file("~/.ssh/id_rsa")

  # }






  # user_data = <<-EOF
  #             #!/bin/bash
  #             sudo apt-get update -y
  #             sudo apt-get install -y nginx
  #             sudo systemctl start nginx
  #             sudo systemctl status nginx
  #              EOF

}
