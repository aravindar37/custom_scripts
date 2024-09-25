variable "region_master" {
  type    = string
  default = "eu-west-1"
}

variable "region_worker" {
  type    = string
  default = "eu-west-2"
}

variable "external_ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "worker_count" {
  type    = number
  default = 2
}