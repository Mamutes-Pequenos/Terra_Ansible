variable "cluster_name" {
  description = "Nome do cluster GKE"
  type        = string
  default     = "gke-cluster-semanal-homol"
}

variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "region" {
  description = "Região onde o cluster será criado"
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "GCP zone para o cluster zonal"
  type        = string
  default     = "us-east1-b"  # Ou a zona que você quer usar
}

variable "grafana_admin_password" {
  description = "Senha grafana Admin"
  type        = string
}

variable "gke_cluster_endpoint" {
  description = "Endpoint do cluster GKE."
  type        = string
  sensitive   = true
}