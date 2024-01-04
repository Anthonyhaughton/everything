resource "aws_instance" "jenkins_node" {
  instance_type          = "t2.micro"
  ami                    = var.server_ami
  key_name               = aws_key_pair.terra_auth.id
  vpc_security_group_ids = [aws_security_group.terra_sg.id]
  subnet_id              = module.dev-vpc.subnet_id
  user_data              = file("./docs/userdata_master.tpl") # Used to bootstrap the instance.

  tags = {
    Name = "jenkins-node"
  }
}

resource "aws_instance" "worker_node" {
  instance_type          = "t2.medium"
  ami                    = var.server_ami
  key_name               = aws_key_pair.terra_auth.id
  vpc_security_group_ids = [aws_security_group.terra_sg.id]
  subnet_id              = module.dev-vpc.subnet_id
  user_data              = file("./docs/userdata_node.tpl") # Used to bootstrap the instance.

  tags = {
    Name = "worker-node"
  }
}