output "vm_ip" {
  description = "IP externo da VM criada"
  value = google_compute_instance.semanal_homol.network_interface[0].access_config[0].nat_ip
}
