resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr
  #cidr_block = "10.10.0.0/16"

  tags = {
    Name        = "my-${var.environment}-vpc"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = var.managed_by
  }
}

resource "aws_subnet" "public_subnets" {
  for_each                = var.subnet_object
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch 

  tags = {
    Name        = each.value.name
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
  for_each = var.subnet_object
  
  # It was a headache trying to figure out how to associate all subnets to the route table but 
  # here you can see all that was needed was to use the "[each.key]" index expression.
  subnet_id      = aws_subnet.public_subnets[each.key].id
  route_table_id = aws_route_table.dev_rt.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.dev_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev_igw.id
}