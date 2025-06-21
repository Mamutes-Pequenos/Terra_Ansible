resource "google_container_cluster" "primary" {
  name     = "cluster_semanal_homol"
  project  = var.project_id
  location = var.zone

  deletion_protection = false

  remove_default_node_pool = false

  initial_node_count = 2

  node_config {
    machine_type = "n2-standard-4"
    disk_type    = "pd-standard"
    disk_size_gb = 30

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}