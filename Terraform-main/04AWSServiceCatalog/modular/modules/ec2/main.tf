data "aws_ami" "machine_ami" {
  filter {
    name   = "image-id"
    values = [var.ami_id]
  }
}

data "aws_key_pair" "keyPair" {
  key_name           = var.key_name
  include_public_key = true
}

resource "aws_security_group" "k-sec-grp" {
  name        = "k-sec-grp"
  description = "Security group and rules"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_ingress_ports
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

resource "aws_instance" "k-test-node" {
  ami                         = data.aws_ami.machine_ami.id
  instance_type               = var.instance_type
  key_name                    = data.aws_key_pair.keyPair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.k-sec-grp.id]
  subnet_id                   = var.subnet_id

  ebs_block_device {
    device_name = "/dev/xvdba"
    volume_type = "gp3"
    volume_size = 15
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 10
  }

  count = var.count_nodes

  tags = {
    Name      = "k-test-node-${count.index}"
    expire-on = "2023-12-31"
  }
}
