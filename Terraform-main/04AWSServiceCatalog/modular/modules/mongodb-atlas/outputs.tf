output "project_id" {
  value = mongodbatlas_project.project.id
}

output "cluster_id" {
  value = mongodbatlas_cluster.cluster.id
}

output "db_user_id" {
  value = mongodbatlas_database_user.db_user.id
}
