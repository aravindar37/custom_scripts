resource "aws_vpc" "om-vpc" {
  provider             = aws.provider
  cidr_block           = "192.168.0.0/20"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc-name
  }
}

resource "aws_internet_gateway" "om-vpc-igw" {
  provider = aws.provider
  vpc_id   = aws_vpc.om-vpc.id
}

data "aws_availability_zones" "om-vpc-azs" {
  provider = aws.provider
  state    = "available"
}


resource "aws_subnet" "om-vpc-subnet" {
  for_each = zipmap(data.aws_availability_zones.om-vpc-azs.names, var.subnet-cidrs)
  # for_each = toset(data.aws_availability_zones.om-vpc-azs.names)
  provider          = aws.provider
  availability_zone = each.key
  vpc_id            = aws_vpc.om-vpc.id
  cidr_block        = each.value
}

resource "aws_route_table" "om-vpc-main-rtbl" {
  provider = aws.provider
  vpc_id   = aws_vpc.om-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.om-vpc-igw.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "om-vpc-main-rtbl"
  }
}

resource "aws_main_route_table_association" "om-vpc-main-rtbl-assoc" {
  provider       = aws.provider
  vpc_id         = aws_vpc.om-vpc.id
  route_table_id = aws_route_table.om-vpc-main-rtbl.id
}

resource "aws_route_table_association" "om-vpc-subnet-rtbl-assoc" {
  for_each       = aws_subnet.om-vpc-subnet
  provider       = aws.provider
  subnet_id      = each.value.id
  route_table_id = aws_route_table.om-vpc-main-rtbl.id
}