data "google_client_config" "default" {}

provider "kubernetes" {
  host  = "https://{var.gke_cluster_endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(var.gke_cluster_ca_certificate)
}

# Configura o provedor do Helm, que usa a conexão do provedor Kubernetes
provider "helm" {
  kubernetes = {
    host  = "https://${var.gke_cluster_endpoint}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(var.gke_cluster_ca_certificate)
  }
}