# Learn Terraform Resource Targeting

This repo is a companion repo to the [Terraform Resource Targeting tutorial](https://developer.hashicorp.com/terraform/tutorials/state/resource-targeting).

It contains Terraform configuration you can use to learn how to implement an S3 bucket and bucket objects with Terraform resource targeting.

-------------------------
In main.tf,

Change resource "random_pet" "bucket_name" { length = 3 # <<<<<<<<<< separator = "-" prefix = "learning" } to resource "random_pet" "bucket_name" { length = 5 # <<<<<<<<<< separator = "-" prefix = "learning" }

$ terraform plan would destroy and recreate bucket and all dependent resources

$ terraform plan -target="random_pet.bucket_name" only changes the bucket name

$ terraform apply -target="random_pet.bucket_name"
