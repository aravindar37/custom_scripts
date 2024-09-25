variable "project_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_type" {
  type = string
  default = "REPLICASET"
}

variable "num_shards" {
  type = number
  default = 1
}

variable "region_name" {
  type = string
}

variable "electable_nodes" {
  type = number
  default = 3
}

variable "read_only_nodes" {
  type = number
  default = 0
}

variable "analytics_nodes" {
  type = number
  default = 0
}

variable "instance_size" {
  type = string
  default = "M10"
}

variable "provider_region" {
  type = string
}

variable "db_user_username" {
  type = string
}

variable "db_user_password" {
  type = string
}

variable "auth_database_name" {
  type = string
  default = "admin"
}

variable "role_name" {
  type = string
}

variable "database_name" {
  type = string
}

variable "org_id" {
  type = string
}