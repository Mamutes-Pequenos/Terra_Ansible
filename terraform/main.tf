terraform {
  backend "gcs" {}
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
  credentials = file(var.credentials_file_path)
}

provider "helm" {
  kubernetes {
    host                   = google_container_cluster.primary.endpoint
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  }
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  deletion_protection = false
  initial_node_count = var.cluster_size

  node_config {
    machine_type = var.machine_type
    disk_type = "pd-standard"
    disk_size_gb = 50

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

resource "helm_release" "prometheus_stack" {
    name       = "stack-prometheus"
    repository = "https://prometheus-community.github.io/helm-charts"
    chart      = "kube-prometheus-stack"
    version          = "57.0.2"

    namespace        = "monitoramento"
    create_namespace = true

   set {
    name  = "grafana.adminPassword"
    value = "deuscaralho"
  }

  set {
    name  = "grafana.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "prometheus.service.type"
    value = "ClusterIP"
  }

  depends_on = [google_container_cluster.primary]
}
