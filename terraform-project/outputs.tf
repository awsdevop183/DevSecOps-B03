output "public-subnet-ids" {
  value = aws_subnet.public-subnets.*.id

}

output "public-subnet-1" {
  value = aws_subnet.public-subnets.0.id

}

output "ec2-ip" {
  value = aws_instance.test-vm.public_ip

}
