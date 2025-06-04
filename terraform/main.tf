provider "google" {
  credentials = file(var.credentials_file_path)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

resource "google_compute_instance" "vm_instance" {
  name         = "ci-terraform-vm"
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
    access_config {}  # libera IP externo
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  tags = ["ssh-conexao", "server"]
}
