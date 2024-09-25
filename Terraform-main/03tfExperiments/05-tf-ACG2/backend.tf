terraform {
  required_version = ">0.12.0"
  backend "s3" {
    region = "eu-west-1"
    key    = "terraform.tfstate"
    bucket = "kbuc8"
  }
}