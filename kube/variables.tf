# ./kubernetes/variables.tf

variable "gke_cluster_name" {
  description = "Nome do cluster GKE para conexão."
  type        = string
}

variable "gke_cluster_endpoint" {
  description = "Endpoint do cluster GKE."
  type        = string
  sensitive   = true
}

variable "gke_cluster_ca_certificate" {
  description = "Certificado de autoridade do cluster GKE."
  type        = string
  sensitive   = true
}

variable "grafana_admin_password" {
  description = "Senha para o usuário 'admin' do Grafana."
  type        = string
  sensitive   = true
}

variable "grafana_ip" {
  description = "Nome do endereço IP para o Grafana."
  type        = string
  default     = "grafana-homol-ip"
}

variable "project_id" {
  description = "ID do projeto GCP onde o cluster GKE está localizado."
  type        = string
  sensitive = true
}

variable "region" {
  description = "Região do GCP onde o cluster GKE está localizado."
  type        = string
  default     = "us-east1"
  sensitive = false
}