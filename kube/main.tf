resource "google_compute_address" "grafana_prod_ip" {
    name = var.grafana_ip
    project = var.project_id
    region = var.region
}

output "grafana_prod_ip" {
  value = google_compute_address.grafana_prod_ip.address
}

resource "helm_release" "prometheus_stack" {
    name       = "promo-stack"
    repository = "https://prometheus-community.github.io/helm-charts"
    chart      = "kube-prometheus-stack"

    namespace        = "monitoramento"
    create_namespace = true

    values = [
        yamlencode({
            grafana = {
                adminUser = "admin"
                
                adminPassword = var.grafana_admin_password
                
                service = {
                    type = "LoadBalancer"
                    loadBalancerIP = resource.google_compute_address.grafana_prod_ip.address
                }
            }
        })
    ]
}