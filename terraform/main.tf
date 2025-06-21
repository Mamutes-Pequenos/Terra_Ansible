terraform {
  backend "gcs" {}
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
  credentials = file(var.gcp_credentials_path)
}

module "gke_cluster" {
  source       = "./gke"
  project_id   = var.project_id
  cluster_name = var.cluster_name
  region       = var.region
  zone         = var.zone
}

module "kubernetes_config" {
  source = "./kube"
  project_id                 = var.project_id
  cluster_name           = module.cluster.name
  gke_cluster_endpoint       = module.cluster.endpoint
  grafana_admin_password     = var.grafana_admin_password
}