resource "aws_vpc" "name" {
  # Arguments

  cidr_block = "192.168.3.0/16"
  tags = {
    "Name" = "Terraform-git-VPC"
  }
}
