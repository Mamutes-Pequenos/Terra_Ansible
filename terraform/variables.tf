variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
  default     = "corded-racer-455623-i7"
}

variable "region" {
  description = "Região GCP"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zona GCP"
  type        = string
  default     = "us-central1-a"
}

variable "machine_type" {
  description = "Tipo da máquina"
  type        = string
  default     = "e2-medium"
}

variable "image" {
  description = "Imagem do sistema operacional"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "disk_size" {
  description = "Tamanho do disco em GB"
  type        = number
  default     = 20
}

variable "public_key_path" {
  description = "Caminho da chave pública SSH"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "credentials_file_path" {
  description = "Caminho para o arquivo JSON da conta de serviço"
  type        = string
}
