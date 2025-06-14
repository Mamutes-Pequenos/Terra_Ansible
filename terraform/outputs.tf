output "kubeconfig" {
  description = "IP externo da VM criada"
  value       = google_container_cluster.semanal_homol.kube_config
}
