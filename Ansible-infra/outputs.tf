output "controller_public_ip" {
  value = aws_instance.controller.public_ip

}

output "controller_ssh" {
  value = "ssh -i ${var.private_key_path} ${var.ssh_user}@${aws_instance.controller.public_ip}"

}

output "node_public_ips" {
  value = aws_instance.node.*.public_ip

}

output "node_private_ips" {
  value = aws_instance.node.*.private_ip

}

output "inventory_file" {
  value = local_file.inventory.filename

}
