# Create public SG
resource "aws_security_group" "public" {
  name        = "public-sg"
  description = "Public sg to access the internet"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # You can change this to your IP /32 to be more secure while testing
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
        Name = "my-dev-sg"
        Project = "1.5"
        #Environment = var.env
        ManagaedBy = "terrafrom"
    }
}