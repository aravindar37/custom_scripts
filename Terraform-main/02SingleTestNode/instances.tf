# data "aws_ssm_parameter" "ubuntu-ami" {
#   provider = aws.provider
#   name     = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20230517"
# }

data "aws_ami" "machine-ami" {
  provider = aws.provider
  filter {
    name   = "image-id"
    values = [var.ami-id]
  }
}

data "aws_key_pair" "sydneyKeyPair" {
  provider           = aws.provider
  key_name           = "sydneyKeyPair"
  include_public_key = true
}




resource "aws_instance" "k-test-node" {
  provider                    = aws.provider
  ami                         = data.aws_ami.machine-ami.id
  instance_type               = var.instance-type
  key_name                    = data.aws_key_pair.sydneyKeyPair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.k-sec-grp.id]
  subnet_id                   = aws_subnet.k-subnet.id

  ebs_block_device {
    device_name = "/dev/xvdba"
    volume_type = "gp3"
    volume_size = 15
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 10
  }

  count = var.count-nodes

  tags = {
    Name      = "k-test-node-${count.index}"
    expire-on = "2023-12-31"
  }
}


