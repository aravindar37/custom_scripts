# data "aws_ssm_parameter" "ubuntu-ami" {
#   provider = aws.provider
#   name     = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20230517"
# }

data "aws_ami" "ubuntu-ami" {
  provider = aws.provider
  filter {
    name   = "image-id"
    values = ["ami-0d02292614a3b0df1"]
  }
}

data "aws_key_pair" "sydneyKeyPair" {
  provider           = aws.provider
  key_name           = "sydneyKeyPair"
  include_public_key = true
}




resource "aws_instance" "k-test-node" {
  provider                    = aws.provider
  ami                         = data.aws_ami.ubuntu-ami.id
  instance_type               = var.instance-type
  key_name                    = data.aws_key_pair.sydneyKeyPair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.k-sec-grp.id]
  subnet_id                   = aws_subnet.k-subnet.id

  ebs_block_device {
    device_name = "/dev/xvdba"
    volume_type = "gp3"
    volume_size = 30
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 10
  }

  tags = {
    Name      = "k-test-node"
    expire-on = "2023-12-31"
  }

  user_data = file("${path.module}/init.sh")

  provisioner "file" {
    source = "README.md"
    destination = "/tmp/README.md"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("/Users/outlander/.ssh/sydneyKeyPair.pem")
      host = self.public_ip
    }
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
#     owner     = "k Gaur"
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