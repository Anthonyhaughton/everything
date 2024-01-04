resource "aws_key_pair" "terra_auth" {
  key_name   = "jenkins_key"
  public_key = file("~/.ssh/jenkins_key.pub") # I used the file func so that I can just point to the key rather than copy and paste the whole ed string
}

resource "aws_security_group" "terra_sg" {
  name        = "dev-sg"
  description = "Allow all traffic"
  vpc_id      = module.dev-vpc.vpc_id

  ingress {
    description = "Allow All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # "-1" covers all protocols TCP, UPD, ICMP, etc.
    cidr_blocks = ["0.0.0.0/0"]
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