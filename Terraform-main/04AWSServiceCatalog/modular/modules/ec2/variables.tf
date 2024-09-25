variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "count_nodes" {
  type = number
}

variable "sg_ingress_ports" {
  type = list(any)
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}
