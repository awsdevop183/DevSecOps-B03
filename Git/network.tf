resource "aws_vpc" "name" {
  # Arguments

  cidr_block = "192.168.3.0/16"
  tags = {
    "Name" = "Terraform-git-VPC"
  }
}

resource "aws_internet_gateway" "git-vpc-igw" {
  vpc_id = aws_vpc.name.id

}


resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.name.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.git-vpc-igw.id
  }

  tags = {
    Name = "Git-public-RT"
  }
}
