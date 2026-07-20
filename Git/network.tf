resource "aws_vpc" "name" {
  # Arguments
  cidr_block = "192.168.0.0/16"
  tags = {
    "Name": "Terraform-git-VPC"
  }
}

resource "aws_internet_gateway" "git-vpc-igw" {
  vpc_id = aws_vpc.name.id
  
}