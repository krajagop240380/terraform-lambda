resource "aws_vpc" "my_vpc_project" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true  	
  tags = {
    Name = "vpc_project"
  }
}

resource "aws_subnet" "my_private_subnet1" {
  vpc_id     = aws_vpc.my_vpc_project.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private_subnet1"
  }
}

resource "aws_subnet" "my_private_subnet2" {
  vpc_id     = aws_vpc.my_vpc_project.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private_subnet2"
  }
}

resource "aws_subnet" "my_public_subnet1" {
  vpc_id     = aws_vpc.my_vpc_project.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet1"
  }
}

resource "aws_subnet" "my_public_subnet2" {
  vpc_id     = aws_vpc.my_vpc_project.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = true	

  tags = {
    Name = "public_subnet2"
  }
}

resource "aws_internet_gateway" "my_vpc_igw" {
  vpc_id = aws_vpc.my_vpc_project.id

  tags = {
    Name = "vpc_igw_project"
  }
}

resource "aws_route_table" "my_vpc_route_table" {
  vpc_id = aws_vpc.my_vpc_project.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_vpc_igw.id
  }

  tags = {
    Name = "vpc_route_table"
  }
}

resource "aws_route_table_association" "my_vpc_pub_subnet1_attach" {
  subnet_id      = aws_subnet.my_public_subnet1.id
  route_table_id = aws_route_table.my_vpc_route_table.id
}

resource "aws_route_table_association" "my_vpc_pub_subnet2_attach" {
  subnet_id      = aws_subnet.my_public_subnet2.id
  route_table_id = aws_route_table.my_vpc_route_table.id
}