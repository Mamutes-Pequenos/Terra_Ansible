provider "google" {
  credentials = file(var.credentials_file_path)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

# Criando o Cluster GKE
resource "google_container_cluster" "semanal_homol" {
  name     = "gke-cluster-semanal-homol"
  location = var.region

  initial_node_count = 3

  # Configuração dos nós do cluster (especificação do pool de nós)
  node_config {
    machine_type = var.machine_type
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

    metadata = {
      ssh-keys = "ubuntu:${file(var.public_key_path)}"
    }

    image_type = "COS"  # Container-Optimized OS
  }

  # Pool de nós com autoescalonamento configurado
  node_pool {
    name       = "default-pool"
    node_count = 3

    # Configuração do autoscaling do node pool
    autoscaling {
      min_node_count = 1
      max_node_count = 5
    }

    node_config {
      machine_type = var.machine_type
      oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    }

  }

  # Configurações de rede do cluster (utilizando VPC padrão)
  network    = "default"
  subnetwork = "default"

}

# Configuração do firewall para permitir o acesso aos serviços do cluster
resource "google_compute_firewall" "allow_ports" {
  name    = "allow-observabilidade-v3"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "3000", "9090"]  # Abertura de portas necessárias para o acesso
  }

  source_ranges = ["0.0.0.0/0"]  # Isso libera acesso público (use com cautela em produção)

  target_tags = ["ssh-conexao", "server"]
}

# Output para o kubeconfig
output "kubeconfig" {
  value = google_container_cluster.semanal_homol.kube_config_raw
}
