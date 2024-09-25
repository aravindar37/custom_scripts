variable "region" {
  type = string
}

variable "vpc-name" {
  type = string
}

variable "instance-type" {
  type = string
}

variable "ami-id" {
  type = string
}

variable "count-nodes" {
  type = number
}

variable "sg-ingress-ports" {
  type = list(any)
}

variable "subnet-cidrs" {
  type = list(string)
}