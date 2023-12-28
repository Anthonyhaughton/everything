resource "aws_key_pair" "key" {
  key_name   = "lamp_key"
  public_key = file("~/.ssh/terra_key.pub")
}

resource "aws_security_group" "lamp_sg" {
  name        = "public-sg"
  description = "Public sg to access the internet"
  vpc_id      = module.lamp-vpc.vpc_id

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

  tags = {
    Name        = "my-lamp-sg"
    Project     = "lamp"
    Environment = module.lamp-vpc.environment
    ManagedBy   = "terraform"
  }
}