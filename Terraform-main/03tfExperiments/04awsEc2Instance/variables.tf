variable "region" {
  type    = string
}

variable "vpc-name" {
  type    = string
}

variable "instance-type" {
  type    = string
}

variable "ports" {
  type = list
}

# variable "k8s-master-hostname" {
#   type    = string
#   default = "k8s-master.mdbrecruit.net"
# }

# variable "k8s-worker-1-hostname" {
#   type    = string
#   default = "k8s-worker-1.mdbrecruit.net"
# }

# variable "k8s-worker-2-hostname" {
#   type    = string
#   default = "k8s-worker-2.mdbrecruit.net"
# }