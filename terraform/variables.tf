# ID do projeto GCP
variable "project_id" {
  type = string
}

# Região do GCP (ex: us-central1, us-east1)
variable "region" {
  default = "us-central1"
}

# Zona do GCP (ex: us-central1-a)
variable "zone" {
  default = "us-central1-a"
}

# Tipo de máquina para os nós do GKE (ex: e2-medium, n1-standard-1)
variable "machine_type" {
  default = "e2-medium"
}

# Imagem do sistema operacional para as instâncias dos nós (ex: ubuntu-os-cloud/ubuntu-2204-lts)
variable "image" {
  default = "ubuntu-os-cloud/ubuntu-2204-lts"
}

# Tamanho do disco para as instâncias do GKE (em GB)
variable "disk_size" {
  default = 20
}

# Caminho para a chave pública SSH usada para acessar os nós
variable "public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"  # Defina o caminho completo, se necessário
}

# Caminho para o arquivo de credenciais do Google Cloud (JSON)
variable "credentials_file_path" {
  type = string
}
