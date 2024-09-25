data "aws_ami" "om-ami" {
  provider = aws.provider
  filter {
    name   = "image-id"
    values = [var.ami-id]
  }
}

data "aws_key_pair" "om-key-pair" {
  provider           = aws.provider
  key_name           = var.key-pair
  include_public_key = true
}

locals {
  enum-subnet = zipmap(range(length(aws_subnet.om-vpc-subnet)), [for subnet in aws_subnet.om-vpc-subnet : subnet])
}

resource "aws_instance" "om-node" {
  for_each                    = local.enum-subnet
  provider                    = aws.provider
  ami                         = data.aws_ami.om-ami.id
  instance_type               = var.om-instance-type
  key_name                    = data.aws_key_pair.om-key-pair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.om-sec-grp.id]
  subnet_id                   = each.value.id

  ebs_block_device {
    device_name           = "/dev/xvdb"
    volume_type           = "io2"
    iops                  = 1000
    volume_size           = 25
    delete_on_termination = true
    tags = {
      name = "xvdb"
    }
  }

  ebs_block_device {
    device_name           = "/dev/xvdc"
    volume_type           = "io2"
    iops                  = 1000
    volume_size           = 25
    delete_on_termination = true
    tags = {
      name = "xvdc"
    }
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 8
  }

  tags = {
    Name      = "tf-om-node-${each.key}"
    expire-on = "2023-12-31"
  }

}


resource "aws_instance" "lb-node" {
  provider                    = aws.provider
  ami                         = data.aws_ami.om-ami.id
  instance_type               = var.ansible-instance-type
  key_name                    = data.aws_key_pair.om-key-pair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.om-sec-grp.id]
  subnet_id                   = local.enum-subnet[0].id

  root_block_device {
    volume_type = "gp3"
    volume_size = 25
  }

  # ebs_block_device {
  #   device_name           = "/dev/xvdb"
  #   volume_type           = "gp3"
  #   volume_size           = 25
  #   delete_on_termination = true
  # }
  tags = {
    Name      = "tf-lb-node"
    expire-on = "2023-12-31"
  }

  depends_on = [aws_instance.om-node]
}




