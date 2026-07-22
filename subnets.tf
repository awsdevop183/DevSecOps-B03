resource "aws_subnet" "git-sub-1" {
  cidr_block = "192.168.0.0/24"
  vpc_id     = aws_vpc.name.id
  tags = {
    "Name" = "git-sub-1"
  }

}
