resource "mongodbatlas_project" "project" {
  org_id = var.org_id
  name = var.project_name
}

resource "mongodbatlas_cluster" "cluster" {
  project_id   = mongodbatlas_project.project.id
  name         = var.cluster_name
  cluster_type = var.cluster_type

  replication_specs {
    num_shards = var.num_shards

    regions_config {
      region_name     = var.region_name
      priority        = 7
      electable_nodes = var.electable_nodes
      read_only_nodes = var.read_only_nodes
      analytics_nodes = var.analytics_nodes
    }
  }

  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_instance_size_name = var.instance_size
  provider_region_name = var.provider_region
}

resource "mongodbatlas_database_user" "db_user" {
  username    = var.db_user_username
  password    = var.db_user_password
  project_id  = mongodbatlas_project.project.id
  auth_database_name = var.auth_database_name

  roles {
    role_name     = var.role_name
    database_name = var.database_name
  }
}
