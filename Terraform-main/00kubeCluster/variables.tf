variable "region" {
  type = string
}

variable "vpc-name" {
  type = string
}

variable "vpc-cidr" {
  type = string
}

variable "subnet-cidr" {
  type = string
}

variable "sg-ingress-ports" {
  type = list(any)
}

variable "instance-type" {
  type = string
}

variable "key-pair" {
  type = string
}

variable "ami-id" {
  type = string
}

variable "k8s-node-hostnames" {
  type = list(string)
}

variable "dns-domain" {
  type = string
}