provider "helm" {
  kubernetes {
    host                   = google_container_cluster.primary.endpoint
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  }
}

resource "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.zone
  remove_default_node_pool = true
  initial_node_count       = 2
  network    = var.network

  ip_allocation_policy {}
}

resource "google_container_node_pool" "primary_nodes" {
  name       = var.cluster_name
  location   = var.zone
  cluster    = google_container_cluster.gke_cluster.name
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    disk_size_gb = 30
    disk_type    = "pd-standard"
  }
}

resource "null_resource" "configure_kubectl" {
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${google_container_cluster.gke_cluster.name} --region ${var.zone} --project ${var.project_id}"
  }

  depends_on = [google_container_cluster.gke_cluster, google_container_node_pool.primary_nodes]
}

resource "helm_release" "prometheus_stack" {
    name       = "stack-prometheus"
    repository = "https://prometheus-community.github.io/helm-charts"
    chart      = "kube-prometheus-stack"
    version          = "57.0.2"

    namespace        = "monitoramento"
    create_namespace = true

    values = [
        yamlencode({
            grafana = {
                adminUser = "admin"
                
                adminPassword = var.grafana_admin_password
                
                service = {
                    type = "LoadBalancer"
                }
            }
        })
    ]
    depends_on = [google_container_cluster.primary]
}
