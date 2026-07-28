resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "AWS_VPC"
  }

}


resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.test.id

}


resource "aws_subnet" "sub-1" {
  cidr_block = "10.0.0.0/24"
  vpc_id     = aws_vpc.test.id
  tags = {
    Name = "Sub-1"
  }

}

resource "aws_subnet" "sub-2" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.test.id
  tags = {
    Name = "Sub-2"
  }

}







resource "local_file" "test" {
  filename = "test.txt"
  content  = "Hello test file"

}












# resource "aws_internet_gateway" "igw" {

#   vpc_id = aws_vpc.test.id

# }

# resource "aws_s3_bucket" "test" {
#   bucket = "bunnyops-3"
# }

# Immutable: we cannot modify the resource

# Mutable: we can modify







# Arguments = Inputs

# Attributes = Resource emitting values
# resource
# data



# resource "aws_vpc" "test" {
#   cidr_block = "192.168.0.0/16"
#   tags = {
#     Name = "Terraform-vpc"
#   }

# }


# aws_vpc  =
# AWS= provider
# vpc= Resource_type


# resource "aws_s3_bucket" "name" {

# }

# aws = provider
# s3_bucket = resource type

# name = resource name

# cidr_block = Arguments

