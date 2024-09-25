# data "aws_ssm_parameter" "ubuntu-ami" {
#   provider = aws.provider
#   name     = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20230517"
# }

data "aws_ami" "ubuntu-ami" {
  provider = aws.provider
  filter {
    name   = "image-id"
    values = [var.ami-id]
  }
}

data "aws_key_pair" "keyPair" {
  provider           = aws.provider
  key_name           = var.key-pair
  include_public_key = true
}


resource "aws_instance" "k8s-node" {
  provider                    = aws.provider
  ami                         = data.aws_ami.ubuntu-ami.id
  instance_type               = var.instance-type
  key_name                    = data.aws_key_pair.keyPair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.k8s-sec-grp.id]
  subnet_id                   = aws_subnet.k8s-subnet.id
  # ebs_block_device {
  #   device_name = "/dev/xvdba"
  #   volume_type = "gp3"
  #   volume_size = 30
  # }
  root_block_device {
    volume_type = "gp3"
    volume_size = 30
  }

  count = length(var.k8s-node-hostnames)

  # user_data = file("installsw.sh")
  tags = {
    Name      = var.k8s-node-hostnames[count.index]
    expire-on = "2023-12-31"
  }

}








# resource "aws_instance" "k8s-master" {
#   provider                    = aws.provider
#   ami                         = data.aws_ami.ubuntu-ami.id
#   instance_type               = var.instance_type
#   key_name                    = data.aws_key_pair.sydneyKeyPair.key_name
#   associate_public_ip_address = true
#   vpc_security_group_ids      = [aws_security_group.k8s-sec-grp.id]
#   subnet_id                   = aws_subnet.k8s-subnet.id
#   ebs_block_device {
#     device_name = "/dev/xvdba"
#     volume_type = "gp3"
#     volume_size = 30
#   }
#   root_block_device {
#     volume_type = "gp3"
#     volume_size = 10
#   }

#   user_data = data.template_file.init-master.rendered
#   tags = {
#     Name      = "k8s-node-0"
#     expire-on = "2023-12-31"
#   }

# }
# resource "aws_instance" "k8s-worker-1" {
#   provider                    = aws.provider
#   ami                         = data.aws_ami.ubuntu-ami.id
#   instance_type               = var.instance_type
#   key_name                    = data.aws_key_pair.sydneyKeyPair.key_name
#   associate_public_ip_address = true
#   vpc_security_group_ids      = [aws_security_group.k8s-sec-grp.id]
#   subnet_id                   = aws_subnet.k8s-subnet.id
#   ebs_block_device {
#     device_name = "/dev/xvdba"
#     volume_type = "gp3"
#     volume_size = 30
#   }
#   root_block_device {
#     volume_type = "gp3"
#     volume_size = 10
#   }

#   user_data = data.template_file.init-worker-1.rendered
#   tags = {
#     Name      = "k8s-node-1"
#     expire-on = "2023-12-31"
#   }

# }
# resource "aws_instance" "k8s-worker-2" {
#   provider                    = aws.provider
#   ami                         = data.aws_ami.ubuntu-ami.id
#   instance_type               = var.instance_type
#   key_name                    = data.aws_key_pair.sydneyKeyPair.key_name
#   associate_public_ip_address = true
#   vpc_security_group_ids      = [aws_security_group.k8s-sec-grp.id]
#   subnet_id                   = aws_subnet.k8s-subnet.id
#   ebs_block_device {
#     device_name = "/dev/xvdba"
#     volume_type = "gp3"
#     volume_size = 30
#   }
#   root_block_device {
#     volume_type = "gp3"
#     volume_size = 10
#   }

#   user_data = data.template_file.init-worker-2.rendered
#   tags = {
#     Name      = "k8s-node-2"
#     expire-on = "2023-12-31"
#   }

# }