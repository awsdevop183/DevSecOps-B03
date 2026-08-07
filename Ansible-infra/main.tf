resource "aws_vpc" "ansible-vpc" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.vpc-name}-vpc"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ansible-vpc.id

  tags = {
    Name = "${var.vpc-name}-igw"
  }

}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public-subnets" {
  vpc_id                  = aws_vpc.ansible-vpc.id
  for_each                = var.public-subnets
  cidr_block              = each.value
  availability_zone       = data.aws_availability_zones.available.names[index(keys(var.public-subnets), each.key)]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc-name}-${each.key}"
  }

}

resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.ansible-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc-name}-public-rt"
  }

}

resource "aws_route_table_association" "pub-rt-associate" {
  route_table_id = aws_route_table.pub-rt.id
  for_each       = var.public-subnets
  subnet_id      = aws_subnet.public-subnets[each.key].id

}
