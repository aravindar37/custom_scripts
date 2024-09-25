provider "aws" {
  region = var.region
}

provider "mongodbatlas" {
  public_key  = var.mongodb_public_key
  private_key = var.mongodb_private_key
}

module "vpc" {
  source      = "./modules/vpc"
  vpc_name    = var.vpc_name
  vpc_cidr    = var.vpc_cidr
  subnet_cidrs = var.subnet_cidrs
}

module "ec2" {
  source            = "./modules/ec2"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  count_nodes       = var.count_nodes
  sg_ingress_ports  = var.sg_ingress_ports
  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.vpc.subnet_id
}


module "mongodb_atlas" {
  source            = "./modules/mongodb-atlas"
  project_name      = var.mongodb_project_name
  org_id            = var.org_id
  cluster_name      = var.mongodb_cluster_name
  cluster_type      = var.mongodb_cluster_type
  num_shards        = var.mongodb_num_shards
  region_name       = var.mongodb_region_name
  electable_nodes   = var.mongodb_electable_nodes
  read_only_nodes   = var.mongodb_read_only_nodes
  analytics_nodes   = var.mongodb_analytics_nodes
  instance_size     = var.mongodb_instance_size
  provider_region   = var.mongodb_provider_region
  db_user_username  = var.mongodb_db_user_username
  db_user_password  = var.mongodb_db_user_password
  auth_database_name = var.mongodb_auth_database_name
  role_name         = var.mongodb_role_name
  database_name     = var.mongodb_database_name
}
