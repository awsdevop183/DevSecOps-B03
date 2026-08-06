resource "aws_instance" "vm" {
  ami           = lookup(var.ami, var.region, "ami-0b6d9d3d33ba97d99")
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public-subnets["subnet-1"].id
  key_name      = var.key_name
  tags = {
    Name = "${var.vpc-name}-VM"
  }

}

# lookup(map, key, default)



