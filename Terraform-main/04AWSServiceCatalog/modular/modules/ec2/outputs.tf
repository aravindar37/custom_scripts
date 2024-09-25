output "instance_ids" {
  value = aws_instance.k-test-node[*].id
}

output "public_ips" {
  value = aws_instance.k-test-node[*].public_ip
}

output "private_ips" {
  value = aws_instance.k-test-node[*].private_ip
}
