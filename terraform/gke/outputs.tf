
output "name" {
  description = "Nome do cluster GKE criado."
  value       = google_container_cluster.primary.name
}

output "endpoint" {
  description = "Endpoint do cluster GKE."
  value       = google_container_cluster.primary.endpoint
}

output "ca_certificate" {
  description = "Certificado de autoridade do cluster GKE"
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  sensitive   = true
}