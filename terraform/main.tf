provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = file(var.credentials_file_path)
}

resource "google_container_cluster" "semanal_homol" {
  name     = "vm01_terraform"
  machine_type = "e2-medium"
  zone =var.zone
  
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

  tags = ["ssh", "app"]
}

