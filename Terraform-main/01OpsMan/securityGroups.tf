resource "aws_security_group" "om-sec-grp" {
  provider    = aws.provider
  name        = "tf-om-sec-grp"
  description = "Security Group for Ops Manager"
  vpc_id      = aws_vpc.om-vpc.id


  dynamic "ingress" {
    for_each = var.sg-ingress-ports
    iterator = port
    content {
      from_port   = port.value[0]
      to_port     = port.value[1]
      protocol    = port.value[2]
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