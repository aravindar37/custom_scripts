count-nodes = 1

instance-type = "t3.micro"
vpc-name      = "k-vpc"
region        = "us-east-1"

# ubuntu 20
# ami-id = "ami-0d02292614a3b0df1"

# ubuntu 22.04
# ami-id              = "ami-0310483fb2b488153" 

# amzn2 
# ami-id = "ami-0a38ff16b1a996d39"

# rhel9
ami-id = "ami-008677ef1baf82eaf"

sg-ingress-ports = [
  [22, 22, "tcp", ["0.0.0.0/0"]], [80, 80, "tcp", ["0.0.0.0/0"]],
  [8443, 8443, "tcp", ["0.0.0.0/0"]],
  [8080, 8080, "tcp", ["0.0.0.0/0"]], [27017, 27017, "tcp", ["0.0.0.0/0"]]
]
subnet-cidrs = ["192.168.0.0/28"]