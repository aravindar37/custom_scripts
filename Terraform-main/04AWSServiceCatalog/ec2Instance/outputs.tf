output "out-region" {
  value = var.region
}

output "vpc-azs" {
  value = element(data.aws_availability_zones.k-vpc-azs.names, 0)
}

# output "public_ip" {
#   description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
#   value = aws_instance.k-test-node.public_ip
# }

# output "private_ip" {
#   description = "The private IP address assigned to the instance"
#   value =  aws_instance.k-test-node.private_ip
# }

output "node_ips" {
  description = "The IP address assigned to the instance"
  value = [
    { "private" : [for instance in aws_instance.k-test-node : instance.private_ip] },
    { "public" : [for instance in aws_instance.k-test-node : instance.public_ip] }
  ]
}