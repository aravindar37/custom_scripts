resource "aws_vpc" "k-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "k-vpc-igw" {
  vpc_id = aws_vpc.k-vpc.id
}

data "aws_availability_zones" "k-vpc-azs" {
  state = "available"
}

resource "aws_subnet" "k-subnet" {
  availability_zone = element(data.aws_availability_zones.k-vpc-azs.names, 0)
  vpc_id            = aws_vpc.k-vpc.id
  cidr_block        = var.subnet_cidrs[0]
}

resource "aws_route_table" "k-rtbl" {
  vpc_id = aws_vpc.k-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k-vpc-igw.id
  }
  tags = {
    Name = "k-rtbl"
  }
}

resource "aws_main_route_table_association" "rtbl_assoc_main" {
  vpc_id         = aws_vpc.k-vpc.id
  route_table_id = aws_route_table.k-rtbl.id
}

resource "aws_route_table_association" "rtbl_assoc_subnet" {
  subnet_id      = aws_subnet.k-subnet.id
  route_table_id = aws_route_table.k-rtbl.id
}
