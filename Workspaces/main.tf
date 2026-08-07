resource "aws_vpc" "terraform-vpc" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc-name
  }

}



resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.terraform-vpc.id

}

resource "aws_subnet" "public-subnets" {
  vpc_id     = aws_vpc.terraform-vpc.id
  for_each   = var.public-subnets
  cidr_block = each.value

  tags = {
    Name = "${var.vpc-name}-${each.key}"
  }

}

resource "aws_subnet" "private-subnets" {
  vpc_id     = aws_vpc.terraform-vpc.id
  for_each   = var.private-subnets
  cidr_block = each.value

  tags = {
    Name = "${var.vpc-name}-${each.key}"
  }

}


resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.terraform-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.terraform-vpc.id

}



resource "aws_route_table_association" "pub-rt-associate" {
  route_table_id = aws_route_table.pub-rt.id
  for_each       = var.public-subnets
  subnet_id      = aws_subnet.public-subnets[each.key].id

}

resource "aws_route_table_association" "private-rt-associate" {
  route_table_id = aws_route_table.private-rt.id
  for_each       = var.private-subnets
  subnet_id      = aws_subnet.private-subnets[each.key].id

}


resource "aws_vpc" "prod-vpc-2" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Drift-vpc"
  }

}
