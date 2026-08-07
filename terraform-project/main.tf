resource "aws_vpc" "prod-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.prod-vpc.id

}

resource "aws_subnet" "public-subnets" {
  vpc_id                  = aws_vpc.prod-vpc.id
  count                   = length(var.public-subs)
  cidr_block              = var.public-subs[count.index]
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-subnet-${count.index + 1}"
  }


}


resource "aws_subnet" "private-subnets" {
  vpc_id            = aws_vpc.prod-vpc.id
  count             = length(var.private-subs)
  cidr_block        = var.private-subs[count.index]
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "Private-subnet-${count.index + 1}"
  }

}

resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.prod-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.prod-vpc.id

}



resource "aws_route_table_association" "pub-rt-associate" {
  route_table_id = aws_route_table.pub-rt.id
  count          = length(var.public-subs)
  subnet_id      = aws_subnet.public-subnets[count.index].id
  # aws_subnet.public-subnets[0].id

}

resource "aws_route_table_association" "private-rt-associate" {
  route_table_id = aws_route_table.private-rt.id
  count          = length(var.private-subs)
  subnet_id      = aws_subnet.private-subnets[count.index].id

}
