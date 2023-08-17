# Create VPC for Requester
resource "aws_vpc" "requester_vpc" {
  cidr_block = var.vpc_cidr_block
  #  enable_dns_hostnames = true
  tags = {
    Name = "requester_vpc"
  }
}

# Create VPC for Accepter
resource "aws_vpc" "accepter_vpc" {
  cidr_block = var.peer_vpc_cidr_block
  #  enable_dns_hostnames = true
  tags = {
    Name = "accepter_vpc"
  }
}

# Create VPC peering connection between both vpcs
resource "aws_vpc_peering_connection" "vpc_peering_connection" {
  vpc_id      = aws_vpc.requester_vpc.id
  peer_vpc_id = aws_vpc.accepter_vpc.id

  auto_accept = true

  tags = {
    Name = "peering_connection"
  }

  depends_on = [
    aws_vpc.requester_vpc,
    aws_vpc.accepter_vpc
  ]
}

# Create Internet Gateway for Requester
resource "aws_internet_gateway" "requester-igw" {
  vpc_id = aws_vpc.requester_vpc.id
  tags = {
    Name = "requester-igw"
  }
}

# Create Route Table for Requester
resource "aws_route_table" "route_table_requester" {
  vpc_id = aws_vpc.requester_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.requester-igw.id
  }

  route {
    cidr_block                = "10.1.5.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering_connection.id
  }
}

# Create Route Table for Accepter
resource "aws_route_table" "route_table_accepter" {
  vpc_id = aws_vpc.accepter_vpc.id

  route {
    cidr_block                = "10.0.5.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering_connection.id
  }
}

# Data for availability Zones
data "aws_availability_zones" "availability_zones" {}

# Create Subnet for Requester
resource "aws_subnet" "subnet_requester" {
  vpc_id                  = aws_vpc.requester_vpc.id
  cidr_block              = var.requester_subnet_cidr_block
  map_public_ip_on_launch = true # This makes public subnet
  availability_zone       = data.aws_availability_zones.availability_zones.names[0]
  tags = {
    Name = "requester-subnet"
  }
}

# Create Subnet for Accepter
resource "aws_subnet" "subnet_accepter" {
  vpc_id                  = aws_vpc.accepter_vpc.id
  cidr_block              = var.accepter_subnet_cidr_block
  map_public_ip_on_launch = false # This makes private subnet
  availability_zone       = data.aws_availability_zones.availability_zones.names[1]
  tags = {
    Name = "accepter-subnet"
  }
}

# Associate Requester Subnet to Requester Route Table
resource "aws_route_table_association" "route_table_requester" {
  subnet_id      = aws_subnet.subnet_requester.id
  route_table_id = aws_route_table.route_table_requester.id
}

# Associate Accepter Subnet to Accepter Route Table
resource "aws_route_table_association" "route_table_accepter" {
  subnet_id      = aws_subnet.subnet_accepter.id
  route_table_id = aws_route_table.route_table_accepter.id
}
