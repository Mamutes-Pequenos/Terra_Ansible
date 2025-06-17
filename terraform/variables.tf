variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "region" {
  description = "Região onde o cluster será criado"
  type        = string
  default     = "us-east1"
}

variable "cluster_name" {
  description = "Nome do cluster GKE"
  type        = string
  default     = "gke-cluster-semanal-homol"
}

variable "network" {
  description = "Nome da VPC a ser usada pelo cluster"
  type        = string
  default     = "default"
}

variable "node_count" {
  description = "Número de nós no node pool"
  type        = number
  default     = 1
}

variable "machine_type" {
  description = "Tipo de máquina a ser usada nos nós"
  type        = string
  default     = "e2-medium"
}

variable "credentials_file_path" {
  description = "Caminho do arquivo de credenciais do GCP"
  type        = string
}
