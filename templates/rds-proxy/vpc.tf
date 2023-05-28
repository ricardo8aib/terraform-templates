# VPC
resource "aws_vpc" "rds_vpc" {
    cidr_block       = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
  tags = {
    Name    = "${var.project}"
  }
}

# Subnet A
resource "aws_subnet" "rds_subnet_a" {
  vpc_id     = aws_vpc.rds_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "${var.region}b"
  tags = {
    Project    = "${var.project}"
  }
}

# Subnet b
resource "aws_subnet" "rds_subnet_b" {
  vpc_id     = aws_vpc.rds_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name    = "${var.project}"
  }
}

# Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "subnet-group"
  subnet_ids = [aws_subnet.rds_subnet_a.id, aws_subnet.rds_subnet_b.id]
}

# Internet Gateway
resource "aws_internet_gateway" "vpv_internet_gateway" {
  vpc_id = aws_vpc.rds_vpc.id

  tags = {
    Project = "${var.project}"
  }
}