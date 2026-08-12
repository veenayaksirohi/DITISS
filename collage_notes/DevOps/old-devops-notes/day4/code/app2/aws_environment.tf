# security group
resource "aws_security_group" "test_security_group" {
  name        = "test-security-group"
  description = "test security group for opening ssh port"
  vpc_id      = "vpc-e658e69c"

  tags = {
    Name = "test-security-group"
  }
}

# security group ingress rule
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.test_security_group.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
}

# security group egress rule
resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.test_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "web-server" {
  # amazon machine image
  ami = "ami-0ecb62995f68bb549"

  # instance type
  instance_type = "t3.micro"

  # pem file name
  key_name = "aug25-batch"

  # security group ids
  vpc_security_group_ids = [

    # reference the id of security group created earlier
    aws_security_group.test_security_group.id
  ]

  # set the name in tags
  tags = {
    Name = "web-server"
  }
}