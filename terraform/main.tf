provider "google" {
  credentials = file(var.credentials_file_path)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  
}

resource "google_compute_instance" "semanal_homol" {
  name         = "vm01_terraform"
  machine_type = var.machine_type
  zone         = var.zone
  
  boot_disk {
    initialize_params {
      image = var.image         
      size  = var.disk_size 
    }
  }

 network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"  
  }

  tags = ["ssh-conexao", "server"]
}
resource "google_compute_firewall" "allow_ports" {
  name    = "allow-observabilidade"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "3000", "9090"]
  }

  target_tags = ["ssh-conexao", "server"]
}
