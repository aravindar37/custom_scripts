resource "aws_security_group" "k-sec-grp" {
  provider    = aws.provider
  name        = "k-sec-grp"
  description = "Allow 443 for traffic to Jenkins"
  vpc_id      = aws_vpc.k-vpc.id

   dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      from_port = port.value[0]
      to_port = port.value[1]
      protocol = port.value[2]
      cidr_blocks = port.value[3]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


