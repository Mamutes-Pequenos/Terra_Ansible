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
                }
            }
        })
    ]
}