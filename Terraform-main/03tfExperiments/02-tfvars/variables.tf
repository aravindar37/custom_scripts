variable "username" {
  type = string
}

variable "age" {
  type = number
}

output "name-age" {
    value = "age of ${var.username} is ${var.age}"
}