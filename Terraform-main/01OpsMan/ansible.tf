
locals {
  enum-om-node-fqdn-pub = zipmap(
    range(length(aws_route53_record.om-node-public-dns-record)),
    [for dnsRecord in aws_route53_record.om-node-public-dns-record : dnsRecord.fqdn]
  )

  enum-om-node-fqdn-pri = zipmap(
    range(length(aws_route53_record.om-node-private-dns-record)),
    [for dnsRecord in aws_route53_record.om-node-private-dns-record : dnsRecord.fqdn]
  )
}


resource "local_file" "ansible-inventory" {
  filename = "./ansible/ansible_inventory"
  content  = <<DOC
%{for index, fqdn in local.enum-om-node-fqdn-pub~}
om${index} ansible_host=${fqdn} ansible_port=22 ansible_user=ubuntu ansible_connection=ssh hostname=${substr(fqdn, 2, length(fqdn))}
%{endfor~}
omlb ansible_host=${aws_route53_record.lb-node-public-dns-record.fqdn} ansible_port=22 ansible_user=ubuntu ansible_connection=ssh hostname=${aws_route53_record.lb-node-private-dns-record.fqdn}

[om_servers]
%{for index, fqdn in local.enum-om-node-fqdn-pub~}
om${index}
%{endfor~}

[om_servers:vars]
%{for index, fqdn in local.enum-om-node-fqdn-pri~}
${index == "0" ? join("", ["appdb_rs_primary", "=", fqdn]) : join("", ["appdb_rs_secondary", index, "=", fqdn])} 
%{endfor~}
opsman_deb=${var.opsman-deb}

[om_lb_servers]
omlb

[om_lb_servers:vars]
%{for index, fqdn in local.enum-om-node-fqdn-pri~}
${index == "0" ? join("", ["om_app_server_1", "=", fqdn]) : ""}
${index == "1" ? join("", ["om_app_server_2", "=", fqdn]) : ""} 
%{endfor~}


DOC
}

resource "null_resource" "execute-ansible-playbook" {

  provisioner "local-exec" {
    command = "ansible-playbook -i ./ansible/ansible_inventory ./ansible/configure_om_playbook.yml"
  }

  depends_on = [local_file.ansible-inventory]
}



