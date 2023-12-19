# Create a VPC
resource "aws_vpc" "terra_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "project-vpc-01"
  }
}

# Create 4 subnets - 2 public 2 private

resource "aws_subnet" "public" {
  count = length(var.subnet_cidrs_public)

  vpc_id            = aws_vpc.terra_vpc.id
  cidr_block        = var.subnet_cidrs_public[count.index]
  availability_zone = var.availability_zones[count.index]
}

resource "aws_subnet" "priv_sub_a" {
  vpc_id                  = aws_vpc.terra_vpc.id
  cidr_block              = var.priv_sub_a_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-a"
  }
}

resource "aws_subnet" "priv_sub_b" {
  vpc_id                  = aws_vpc.terra_vpc.id
  cidr_block              = var.priv_sub_b_cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-b"
  }
}

resource "aws_internet_gateway" "terra_igw" {
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name = "project_igw"
  }
}

resource "aws_route_table" "terra_rt" {
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route" "public_rt" {
  route_table_id         = aws_route_table.terra_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terra_igw.id
}

# Associate public subnets to public rt. This got kind of high level with vars. Need to look into more.
# 10:03PM - instead of trying to be fancy just create 2 route assoc and remake all 4 subnets indiviually

resource "aws_route_table_association" "public" {
  count = length(var.subnet_cidrs_public)

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.terra_rt.id
}

# Create public SG
resource "aws_security_group" "terra_sg" {
  Name        = "public-sg"
  description = "Public sg to access the internet"
  vpc_id      = aws_vpc.terra_vpc.id

  ingress {
    description = "Allow All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}