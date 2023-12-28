resource "aws_vpc" "lamp-vpc" {
  #cidr_block = var.vpc_cidr
  cidr_block = "10.10.0.0/16"

  tags = {
    Name        = "my-lamp-vpc"
    Project     = "lamp"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_subnet" "public_subnets" {
  for_each                = var.subnet_object
  vpc_id                  = aws_vpc.lamp-vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name        = each.value.name
    Project     = "lamp"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_internet_gateway" "lamp_igw" {
  vpc_id = aws_vpc.lamp-vpc.id

  tags = {
    Name        = "my-lamp-igw"
    Project     = "lamp"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_route_table" "lamp_rt" {
  vpc_id = aws_vpc.lamp-vpc.id

  tags = {
    Name        = "my-lamp-rt"
    Project     = "lamp"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_route_table_association" "route_assoc" {
  for_each = var.subnet_object
  
  # It was a headache trying to figure out how to associate all subnets to the route table but 
  # here you can see all that was needed was to use the "[each.key]" index expression.
  subnet_id      = aws_subnet.public_subnets[each.key].id
  route_table_id = aws_route_table.lamp_rt.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.lamp_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lamp_igw.id
}