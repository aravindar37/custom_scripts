
# output "vpc-azs" {
#   value = data.aws_availability_zones.om-vpc-azs.names
# }

# output "vpc-subnets" {
#   value = [for subnet in aws_subnet.om-vpc-subnet: subnet.id ]
# }

output "om-node-ips" {
  value = {
    "public" : [for instance in aws_instance.om-node : instance.public_ip],
    "private" : [for instance in aws_instance.om-node : instance.private_ip],
    "fqdn" : [for dnsRecord in aws_route53_record.om-node-public-dns-record : dnsRecord.fqdn]
  }
}

output "lb-node-ips" {
  value = {
    "public" : aws_instance.lb-node.public_ip,
    "private" : aws_instance.lb-node.private_ip,
    "fqdn" : aws_route53_record.lb-node-public-dns-record.fqdn
  }
}





# output "lb-node-ips" {
#   value = {
#     "public" : aws_instance.lb-node.public_ip,
#     "private" : aws_instance.lb-node.private_ip
#   }
# }


