instance-type = "t2.micro"
region        = "ap-southeast-2"

key-pair = "sydneyKeyPair"

# ubuntu
ami-id = "ami-0d02292614a3b0df1"

vpc-name    = "k8s-vpc"
vpc-cidr    = "192.168.0.0/20"
subnet-cidr = "192.168.0.0/28"
dns-domain  = "k8snodes.net."

k8s-node-hostnames = ["master", "worker1", "worker2"]

sg-ingress-ports = [[22, 22, "tcp", ["0.0.0.0/0"]], [80, 80, "tcp", ["0.0.0.0/0"]], [443, 443, "tcp", ["0.0.0.0/0"]],
  [6443, 6443, "tcp", ["0.0.0.0/0"]], [2379, 2380, "tcp", ["0.0.0.0/0"]],
  [6783, 6783, "tcp", ["0.0.0.0/0"]], [6783, 6783, "udp", ["0.0.0.0/0"]],
  [10248, 10260, "tcp", ["0.0.0.0/0"]], [30000, 32767, "tcp", ["0.0.0.0/0"]], [0, 0, "all", ["192.168.0.0/28"]]
]

