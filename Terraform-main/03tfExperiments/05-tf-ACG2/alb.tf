resource "aws_alb" "application_lb" {
    provider = aws.region_master
    name = "jenkins-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [ aws_security_group.sg_lb.id ]
    subnets = [ aws_subnet.subnet_master_1.id, aws_subnet.subnet_master_2.id ]
    tags = {
        Name = "jenkins-lb"
    }
}

 