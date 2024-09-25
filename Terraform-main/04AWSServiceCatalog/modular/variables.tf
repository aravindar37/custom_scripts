# ======================================================
# VPC module variables
# ======================================================

variable "region" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

# ======================================================
# EC2 module variables
# ======================================================

variable "ami_id" {
  type = string
}

variable "count_nodes" {
  type = number
}

variable "sg_ingress_ports" {
  type = list(any)
}

variable "subnet_cidrs" {
  type = list(string)
}

variable "key_name" {
  type = string
}

# ======================================================
# MongoDB Atlas module variables
# ======================================================

variable "mongodb_public_key" {
  type = string
}

variable "mongodb_private_key" {
  type = string
}

variable "org_id" {
  type = string
}

variable "mongodb_project_name" {
  type = string
}

variable "mongodb_cluster_name" {
  type = string
}

variable "mongodb_cluster_type" {
  type = string
}

variable "mongodb_num_shards" {
  type = number
}

variable "mongodb_region_name" {
  type = string
}

variable "mongodb_electable_nodes" {
  type = number
  default = 3
}

variable "mongodb_read_only_nodes" {
  type = number
  default = 0
}

variable "mongodb_analytics_nodes" {
  type = number
  default = 0
}

variable "mongodb_instance_size" {
  type = string
}

variable "mongodb_provider_region" {
  type = string
}

variable "mongodb_db_user_username" {
  type = string
}

variable "mongodb_db_user_password" {
  type = string
}

variable "mongodb_auth_database_name" {
  type = string
  default = "admin"
}

variable "mongodb_role_name" {
  type = string
}

variable "mongodb_database_name" {
  type = string
}