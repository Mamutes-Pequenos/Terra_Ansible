variable "project_id" {
  type        = string
}

variable "region" {
  default     = "us-central1"
}

variable "zone" {
  default     = "us-central1-a"
}

variable "machine_type" {
  default     = "e2-medium"
}

variable "image" {
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "disk_size" {
  default     = 20
}

variable "public_key_path" {
  default     = "~/.ssh/id_rsa.pub"  
}

variable "credentials_file_path" {
  type        = string
}