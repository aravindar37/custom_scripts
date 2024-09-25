resource "aws_vpc" "vpc_master" {
  provider             = aws.region_master
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    name = "master-vpc-jenkins"
  }
}

resource "aws_vpc" "vpc_worker" {
  provider             = aws.region_worker
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    name = "worker-vpc-jenkins"
  }
}

resource "aws_internet_gateway" "igw_master" {
  provider = aws.region_master
  vpc_id   = aws_vpc.vpc_master.id
}

resource "aws_internet_gateway" "igw_worker" {
  provider = aws.region_worker
  vpc_id   = aws_vpc.vpc_worker.id
}

data "aws_availability_zones" "azs_master" {
  provider = aws.region_master
  state    = "available"
}

resource "aws_subnet" "subnet_master_1" {
  provider          = aws.region_master
  availability_zone = element(data.aws_availability_zones.azs_master.names, 0)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.1.0/24"
}

resource "aws_subnet" "subnet_master_2" {
  provider          = aws.region_master
  availability_zone = element(data.aws_availability_zones.azs_master.names, 1)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.2.0/24"
}

resource "aws_subnet" "subnet_worker_1" {
  provider   = aws.region_worker
  vpc_id     = aws_vpc.vpc_worker.id
  cidr_block = "192.168.1.0/24"
}

resource "aws_vpc_peering_connection" "master_worker" {
  provider    = aws.region_master
  vpc_id      = aws_vpc.vpc_master.id
  peer_vpc_id = aws_vpc.vpc_worker.id
  peer_region = var.region_worker
}

resource "aws_vpc_peering_connection_accepter" "accept_peering" {
  provider                  = aws.region_worker
  vpc_peering_connection_id = aws_vpc_peering_connection.master_worker.id
  auto_accept               = true
}

resource "aws_route_table" "rtbl_master" {
  provider = aws.region_master
  vpc_id   = aws_vpc.vpc_master.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_master.id
  }
  route {
    cidr_block                = "192.168.1.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.master_worker.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "rtbl-master"
  }
}

resource "aws_main_route_table_association" "set_rtbl_assoc_main_master" {
  provider       = aws.region_master
  vpc_id         = aws_vpc.vpc_master.id
  route_table_id = aws_route_table.rtbl_master.id
}

resource "aws_route_table_association" "rtbl_assoc_subnet_1_master" {
  provider       = aws.region_master
  subnet_id      = aws_subnet.subnet_master_1.id
  route_table_id = aws_route_table.rtbl_master.id
}

resource "aws_route_table" "rtbl_worker" {
  provider = aws.region_worker
  vpc_id   = aws_vpc.vpc_worker.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_worker.id
  }
  route {
    cidr_block                = "10.0.1.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.master_worker.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "rtbl-worker"
  }
}

resource "aws_main_route_table_association" "set_rtbl_assoc_main_worker" {
  provider       = aws.region_worker
  vpc_id         = aws_vpc.vpc_worker.id
  route_table_id = aws_route_table.rtbl_worker.id
}


resource "aws_route_table_association" "rtbl_assoc_subnet_1_worker" {
  provider       = aws.region_worker
  subnet_id      = aws_subnet.subnet_worker_1.id
  route_table_id = aws_route_table.rtbl_worker.id
}