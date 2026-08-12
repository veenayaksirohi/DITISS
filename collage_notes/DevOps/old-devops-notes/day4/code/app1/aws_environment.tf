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
