resource "aws_vpc" "k-vpc" {
  provider             = aws.provider
  cidr_block           = "192.168.0.0/20"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "k-vpc"
  }
}

resource "aws_security_group" "k-sec-grp" {
  provider    = aws.provider
  name        = "k8s-sec-grp"
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

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 6443
#     to_port     = 6443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 2379
#     to_port     = 2380
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 6783
#     to_port     = 6783
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 6784
#     to_port     = 6784
#     protocol    = "udp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 10248
#     to_port     = 10260
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 30000
#     to_port     = 32767
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

