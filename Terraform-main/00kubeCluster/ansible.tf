
# locals {
#   enum-fqdn-pub = zipmap(
#     range(length(aws_route53_record.public)),
#     [for dnsRecord in aws_route53_record.public : dnsRecord.fqdn]
#   )

#   enum-fqdn-pri = zipmap(
#     range(length(aws_route53_record.private)),
#     [for dnsRecord in aws_route53_record.private : dnsRecord.fqdn]
#   )
# }

locals {
  instance-dtls = { for i, v in aws_instance.k8s-node : i => [v.tags.Name, v.public_ip, v.private_ip, "ssh -i ~/.ssh/sydneyKeyPair.pem ubuntu@${v.public_ip}"] }
}


output "fqdns" {
  value = [
    { "public" : local.instance-dtls }
  ]
}

resource "local_file" "ansible-inventory" {
  filename = "./ansible/ansible_inventory"
  content  = <<DOC
%{for index, dtl in local.instance-dtls~}
${dtl.0} ansible_host=${dtl.1} ansible_port=22 ansible_user=ubuntu ansible_connection=ssh
%{endfor~}
DOC
}

resource "null_resource" "execute-ansible-playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ./ansible/ansible_inventory ./ansible/configure_k8s_playbook.yml --key-file=/Users/outlander/.ssh/sydneyKeyPair.pem"
  }

  depends_on = [local_file.ansible-inventory]
}

