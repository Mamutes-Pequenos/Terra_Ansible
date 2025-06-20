output "cluster_name" {
  description = "Nome do cluster GKE criado"
  value       = google_container_cluster.gke_cluster.name
}

output "cluster_endpoint" {
  description = "Endpoint do cluster GKE"
  value       = google_container_cluster.gke_cluster.endpoint
}

output "cluster_region" {
  description = "Região do cluster"
  value       = google_container_cluster.gke_cluster.location
}