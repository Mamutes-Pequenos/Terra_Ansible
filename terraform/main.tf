provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = file(var.credentials_file_path)
}

resource "google_container_cluster" "gke_cluster" {
  name     = "gke-cluster-${var.env}" # pode ser prod ou stage
  location = var.zone

  initial_node_count = 1

  node_config {
    machine_type = var.machine_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  remove_default_node_pool = false
  enable_autorepair        = true
  enable_autoupgrade       = true
}

output "kubernetes_endpoint" {
  value = google_container_cluster.gke_cluster.endpoint
}
