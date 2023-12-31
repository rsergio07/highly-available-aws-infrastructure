# main.tf

provider "aws" {
  region = "us-east-1" # Specify your desired AWS region
}

# S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "highly-available-project"

  tags = {
    Name        = "MyBucket"
    Environment = "Production"
  }
}

# VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "MyVPC"
  }
}

# Subnet in Availability Zone A
resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "MySubnetA"
  }
}

# Subnet in Availability Zone B
resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "MySubnetB"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "MyIGW"
  }
}

# Route Table for Subnet A
resource "aws_route_table" "route_table_a" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "MyRouteTableA"
  }
}

# Associate Subnet A with Route Table A
resource "aws_route_table_association" "subnet_a_association" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.route_table_a.id
}

# Route Table for Subnet B
resource "aws_route_table" "route_table_b" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "MyRouteTableB"
  }
}

# Associate Subnet B with Route Table B
resource "aws_route_table_association" "subnet_b_association" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.route_table_b.id
}

# Security Group for EC2 Instances
resource "aws_security_group" "instance_security_group" {
  name        = "instance-sg"
  description = "Security group for EC2 instances"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance in Subnet A
resource "aws_instance" "instance_a" {
  ami             = "ami-00b8917ae86a424c9" # Specify your desired AMI ID
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.subnet_a.id
  security_groups = [aws_security_group.instance_security_group.id]

  tags = {
    Name = "MyEC2InstanceA"
  }
}

# EC2 Instance in Subnet B
resource "aws_instance" "instance_b" {
  ami             = "ami-00b8917ae86a424c9" # Specify your desired AMI ID
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.subnet_b.id
  security_groups = [aws_security_group.instance_security_group.id]

  tags = {
    Name = "MyEC2InstanceB"
  }
}