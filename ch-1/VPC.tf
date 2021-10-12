# Create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpn_ip
  tags = {
    Name = "Demo VPC"
  }
}

# Create Web Public Subnet

resource "aws_subnet" "web-subnet-1" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.web_ip
  availability_zone       = var.az
  map_public_ip_on_launch = true

  tags = {
    Name = "Web-1a"
  }
}

# Create Application Private Subnet

resource "aws_subnet" "application-subnet-1" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.app_ip
  availability_zone       = var.az
  map_public_ip_on_launch = false

  tags = {
    Name = "Application-1a"
  }
}

# Create Database Private Subnet

resource "aws_subnet" "database-subnet-1" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.db_ip
  availability_zone = "us-east-1a"

  tags = {
    Name = "Database-1a"
  }
}