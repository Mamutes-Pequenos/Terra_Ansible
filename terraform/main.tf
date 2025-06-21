# VARIAVEIS PARA O MAIN
variable "project_id" {
  description = "ID do projeto no Google Cloud."
  type        = string
}

variable "region" {
  description = "Região GCP para provisionar os recursos."
  type        = string
}

variable "cluster_name" {
  description = "Nome do cluster a ser criado"
  type        = string
}

variable "grafana_admin_password" {
  description = "Senha para o usuário 'admin' do Grafana."
  type        = string
  sensitive   = true
}

variable "gke_zone" {
  description = "Zona GCP específica para o cluster GKE (ex: us-central1-a)."
  type        = string
}

# AQUI COMECA A PUTARIA
terraform {
  backend "gcs" {}
}

provider "google" {
  project = var.project_id
  region  = var.region
}

#modulo pro gke
module "gke_cluster" {
  source       = "./gke"
  project_id   = var.project_id
  cluster_name = var.cluster_name
  region       = var.region
  zone         = var.gke_zone
}

#modulo pro kube
module "kubernetes_config" {
    depends_on = [module.gke_cluster]
    source = "./kube"
    project_id                 = var.project_id
    gke_cluster_name           = module.gke_cluster.name
    gke_cluster_endpoint       = module.gke_cluster.endpoint
    gke_cluster_ca_certificate = module.gke_cluster.ca_certificate
    grafana_admin_password     = var.grafana_admin_password
}