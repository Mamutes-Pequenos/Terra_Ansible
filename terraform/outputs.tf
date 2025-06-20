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

output "kubeconfig_command" {
  description = "Comando para obter credenciais do cluster"
  value = "gcloud container clusters get-credentials ${google_container_cluster.gke_cluster.name} --region ${google_container_cluster.gke_cluster.location} --project ${var.project_id}"
}

# Expõe o certificado de autoridade para conexão segura
output "ca_certificate" {
  description = "Certificado de autoridade do cluster GKE (codificado em base64)."
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  sensitive   = true
}