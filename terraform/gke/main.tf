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