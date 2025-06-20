#GOOGLE-BUCKET-----------------------------------------------------------
terraform {
  backend "gcs" {}
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
  credentials = file(var.gcp_credentials_path)
}
#fim-GOOGLE-BUCKET-----------------------------------------------------------

#PROVIDER --------------------------------------------------------------
data "google_client_config" "default" {}

provider "kubernetes" {
  host = google_container_cluster.primary.endpoint
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host  = google_container_cluster.primary.endpoint
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  }
}
#fim-PROVIDER--------------------------------------------------------

#GKE-----------------------------------------------------------------
resource "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.zone
  remove_default_node_pool = true
  initial_node_count       = 2
  network    = var.network

  ip_allocation_policy {}

    node_config {
    machine_type = var.machine_type
    disk_type = "pd-standard"
    disk_size_gb = 50

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
#fim-GKE------------------------------------------------------------

#TERRAFORM----------------------------------------------------------
data "google_compute_address" "grafana_ip" {
    name = var.grafana_ip
    project = var.project_id
    region = var.region
}

resource "helm_release" "prometheus_stack" {
    name       = "stack-prometheus"
    repository = "https://prometheus-community.github.io/helm-charts"
    chart      = "kube-prometheus-stack"

    namespace        = "monitoramento"
    create_namespace = true
   values = [
        yamlencode({
            grafana = {
                adminUser = "admin"
                
                adminPassword = var.grafana_admin_password
                
                service = {
                    type = "LoadBalancer"
                    loadBalancerIP = data.google_compute_address.grafana_ip.address
                }
            }
        })
    ]
}
#fim-TERRAFORM----------------------------------------------------------