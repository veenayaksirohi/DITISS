terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.22.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# security group
resource "aws_security_group" "sg_test" {
  name        = "test security group"
  description = "used to test the ssh"
  tags = {
    Name = "test security group"
  }
}

# security group ingress rule for ssh
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.sg_test.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

# security group egress rule
resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.sg_test.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "controller" {
  ami = "ami-0ecb62995f68bb549"
  key_name = "aug25-batch"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sg_test.id]
  tags = {
    Name = "controller"
  }
}

resource "aws_instance" "target1" {
  ami = "ami-0ecb62995f68bb549"
  key_name = "aug25-batch"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sg_test.id]
  tags = {
    Name = "target1"
  }
}

resource "aws_instance" "target2" {
  ami = "ami-0ecb62995f68bb549"
  key_name = "aug25-batch"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sg_test.id]
  tags = {
    Name = "target2"
  }
}