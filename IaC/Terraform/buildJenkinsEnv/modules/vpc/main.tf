resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = "my-${var.environment}-vpc"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = var.managed_by
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = var.subnet_object["subnet_a"].cidr
  availability_zone       = var.subnet_object["subnet_a"].availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch 

  tags = {
    Name        = "jenkins-subnet"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = var.managed_by
  }
}

resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name        = "my-${var.environment}-igw"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = var.managed_by
  }
}

resource "aws_route_table" "dev_rt" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name        = "my-${var.environment}-rt"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = var.managed_by
  }
}

resource "aws_route_table_association" "route_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.dev_rt.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.dev_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev_igw.id
}