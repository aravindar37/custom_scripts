# To read an environment variable, export the variable in environment as below
# export TF_VAR_inputName=Sawyer
variable "inputName" {
    type = string
}

variable "name" {
    type = string
    default = "James Bond"
}
variable "age" {
    type = number
    default = 50
}

variable "docker_ports" {
    type = list(
        object(
            {
                internal = number
                external = number
                protocol = string
            }
        )
    )
    default = [{
      external = 80
      internal = 8080
      protocol = "tcp"
    }]
}

variable "user-age" {
  type = map
  default = {
    gaurav = 20
    saurav = 16
  }
}

# https://www.bitslovers.com/terraform-variable-types/
# https://developer.hashicorp.com/terraform/language/values/variables



