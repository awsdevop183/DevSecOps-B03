# resource "null_resource" "tools" {

#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt update -y",
#       "sudo apt install nginx jq unzip -y"

#     ]

#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       host        = aws_instance.test-vm.public_ip
#       private_key = file("~/.ssh/id_rsa")
#     }
#   }

#   provisioner "file" {
#     source      = "./test.sh"
#     destination = "/tmp/test.sh"
#   }

#   connection {
#     type        = "ssh"
#     user        = "ubuntu"
#     host        = aws_instance.test-vm.public_ip
#     private_key = file("~/.ssh/id_rsa")

#   }

#   provisioner "local-exec" {
#     command = "echo The server's IP address is ${aws_instance.test-vm.public_ip}"
#   }

# }
