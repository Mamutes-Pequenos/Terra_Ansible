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

variable "network" {
  description = "Nome da VPC a ser usada pelo cluster"
  type        = string
  default     = "default"
}

variable "machine_type" {
  description = "Tipo de máquina a ser usada nos nós"
  type        = string
  default     = "e2-medium"
}