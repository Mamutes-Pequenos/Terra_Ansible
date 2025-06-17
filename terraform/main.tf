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
    disk_size_gb = 20
    disk_type    = "pd-standard"
  }
}
