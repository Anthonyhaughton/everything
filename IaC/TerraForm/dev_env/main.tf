# Create a VPC
resource "aws_vpc" "terra_vpc" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_support   = true # This option defaults to true, I'm only adding it for this tut.
  enable_dns_hostnames = true # This defaults to false you need to add this if you want this.

  tags = {
    Name = "dev"
  }
}

# Create a Public Subnet
resource "aws_subnet" "terra_subnet" {
  vpc_id                  = aws_vpc.terra_vpc.id
  cidr_block              = "10.20.1.0/24"
  map_public_ip_on_launch = true # This option is false by default. We want this pub sub to have an IP on creation.
  availability_zone       = "us-east-1a"

  tags = {
    Name = "dev-public"
  }
}

# Create a Internet Gateway
resource "aws_internet_gateway" "terra_igw" {
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name = "dev-igw"
  }
}

# Create a Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name = "dev-public-rt"
  }
}

# Link the public route table to the IGW and allow all traffic
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terra_igw.id
}

# Associate the route to the internet with the pub subnet
resource "aws_route_table_association" "terra_assoc_a" {
  subnet_id      = aws_subnet.terra_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Create a SG
resource "aws_security_group" "terra_sg" {
  name        = "dev-sg"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.terra_vpc.id

  ingress {
    description = "Allow All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # "-1" covers all protocols TCP, UPD, ICMP, etc.
    cidr_blocks = ["209.190.236.186/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev_sg"
  }
}

# Create key pair for EC2. In VSCode terminal; I ran "ssh-keygen.exe -t ed25519" 
resource "aws_key_pair" "terra_auth" {
  key_name   = "terra_key"
  public_key = file("~/.ssh/terra_key.pub") # I used the file func so that I can just point to the key rather than copy and paste the whole ed string
}

# Create an Instance
resource "aws_instance" "dev_node" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.terra_auth.id
  vpc_security_group_ids = [aws_security_group.terra_sg.id]
  subnet_id              = aws_subnet.terra_subnet.id
  user_data              = file("userdata.tpl") # Used to bootstrap the instance.

  tags = {
    Name = "dev-node"
  }
}
