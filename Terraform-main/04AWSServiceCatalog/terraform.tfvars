region = "us-east-1"
vpc_name = "k-vpc"
vpc_cidr = "192.168.0.0/20"
instance_type = "t3.micro"
ami_id = "ami-0eaf7c3456e7b5b68"  # Update with your preferred AMI ID
count_nodes = 1
key_name = "usEastKP"  # Update with your actual key pair name
sg_ingress_ports = [
  [22, 22, "tcp", ["0.0.0.0/0"]],
  [80, 80, "tcp", ["0.0.0.0/0"]],
  [8443, 8443, "tcp", ["0.0.0.0/0"]],
  [8080, 8080, "tcp", ["0.0.0.0/0"]],
  [27017, 27017, "tcp", ["0.0.0.0/0"]]
]
subnet_cidrs = ["192.168.0.0/28"]

org_id = "663b15f466e117266af045bb"
mongodb_project_name = "p1"
mongodb_cluster_name = "cluster1"
mongodb_cluster_type = "REPLICASET"
mongodb_num_shards = 1
mongodb_electable_nodes = 3
mongodb_region_name = "US-EAST-1"
mongodb_instance_size = "M0"
mongodb_provider_region = "US-EAST-1"
mongodb_db_user_username = "mongoadmin"
mongodb_db_user_password = "harekrishna"
mongodb_role_name = "readWrite"
mongodb_database_name = "test"


