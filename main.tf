provider "aws" {
  region = "eu-north-1"
}

# Step 1: Create a Security Group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_sg"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "amalan-sg"
  }
}

# Step 2: Launch EC2 Instance
resource "aws_instance" "amalan_ec2" {
  ami           = "ami-0013b4404496ef718" # for eu-north-1
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "amalan-secure-server"
  }
}
