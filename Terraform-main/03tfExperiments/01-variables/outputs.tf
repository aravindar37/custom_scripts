output "name-age" {
  value = "Hello ${var.name}, your age is ${var.age}"
}
output "input-name" {
  value = "Input name was ${var.inputName}"
}
output "docker_ports" {
  value= var.docker_ports
}

output "user-age" {
  value = "Age of gaurav is ${lookup(var.user-age, "gaurav")}"
}
# tf plan -var "name=Shrek" -var "age=45"