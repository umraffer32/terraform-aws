resource "aws_vpc" "main" {
  tags = {
    Name = "VPC-1"
  }

  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "igw" {
  tags = {
    Name = "VPC-1-IGW"
  }

  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "public" {
  tags = {
    Name = "VPC-1-Public-Subnet"
  }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_1" {
  tags = {
    Name = "VPC-1-Private-Subnet-1"
  }

  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_subnet" "private_2" {
  tags = {
    Name = "VPC-1-Private-Subnet-2"
  }

  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_route_table" "public" {
  tags = {
    Name = "VPC-1-Public-RTB"
  }

  vpc_id = aws_vpc.main.id
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private_1" {
  tags = {
    Name = "VPC-1-Private-RTB-1"
  }

  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "private_2" {
  tags = {
    Name = "VPC-1-Private-RTB-2"
  }

  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_1.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_2.id
}

resource "aws_route" "private_1_nat" {
  route_table_id         = aws_route_table.private_1.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_instance.nat.primary_network_interface_id
}

resource "aws_route" "private_2_nat" {
  route_table_id         = aws_route_table.private_2.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_instance.nat.primary_network_interface_id
}
