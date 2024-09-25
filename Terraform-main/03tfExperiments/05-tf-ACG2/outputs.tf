output "jenkins_master_public_ip" {
  value = aws_instance.ec2_jenkins_master.public_ip
}

output "jenkins_worker_public_ips" {
  value = {
    for instance in aws_instance.ec2_jenkins_worker :
    instance.id => instance.public_ip
  }
}