# 🧱 Terra_Ansible

Provisionamento automatizado de infraestrutura com foco em ambientes Kubernetes em nuvem pública. Este repositório reúne todas as definições de infraestrutura, deploy e monitoramento utilizadas no projeto, com pipelines GitHub Actions, Terraform, Prometheus e Grafana.

> 🎯 Ambientes isolados  
> 🔧 Infraestrutura como código  
> 🚀 Deploy contínuo  
> 📡 Observabilidade acoplada

---

## 🧭 Contexto do Projeto

Ambientes reais de desenvolvimento exigem segmentação, automação e visibilidade. Este projeto aborda a criação de um cluster Kubernetes via GKE, configurado para múltiplos namespaces, provisionado com Terraform e implantado automaticamente com GitHub Actions.

Além disso, Prometheus e Grafana foram incorporados ao ambiente como camadas de observabilidade, acessíveis via Ingress Controller.

---

## 🧩 Arquitetura da Solução

> _Diagrama será inserido aqui em imagem hospedada no futuro_

```
Cluster: gke-cluster-homol
Namespaces:
├── observabilidade
├── dbnamespace
Serviços:
├── Prometheus: ClusterIP
├── Grafana: ClusterIP
Ingress:
├── /grafana
├── /prometheus
```

---

## ⚙️ Stack e Componentes Utilizados

### Provisionamento
- Terraform com Google Provider
- Variáveis controladas via `.tfvars` e `variables.tf`
- Cluster GKE com 2 nós `e2-medium` provisionado automaticamente

### Deploy e Orquestração
- Kubernetes via `kubectl`
- YAMLs organizados por módulos:
  - `k8s-banco/`
  - `k8s-grafana/`
  - `k8s-prometheus/`
  - `k8s-observabilidade/`
  - `k8s-ingress-nginx/`

### CI/CD
- GitHub Actions
- Pipeline `pipeInfra.yml` com etapas:
  - Auth GCP via base64
  - `terraform init` + `apply`
  - `kubectl apply` de todos os manifests
  - Ingress rules aplicadas após readiness do controller

---

## 🚀 Automação na Prática

A pipeline de deploy roda automaticamente a cada push na branch `developer4`.  
Todas as etapas são orquestradas conforme abaixo:

```yaml
✅  GCP credentials base64 -> decodificação
✅  Terraform Init & Apply -> cluster GKE
✅  Resize automático do node pool
✅  Deploys: Prometheus, Grafana, Banco
✅  Aplicação de namespaces
✅  Instalação do NGINX Ingress Controller
✅  Regras de rota /grafana e /prometheus
```

---

## 📊 Observabilidade Integrada

O monitoramento é garantido por dois pods:

- **Prometheus** coleta métricas do cluster e aplicações via endpoints
- **Grafana** acessa e renderiza dashboards a partir do Prometheus

🔐 Ambos expostos com Ingress NGINX em paths distintos:
- `http://<ip-externo>/prometheus`
- `http://<ip-externo>/grafana`

---

## 🧪 Execução e Testes Locais

> Pré-requisitos:
> - Conta GCP ativa com permissões
> - Ferramentas: `terraform`, `gcloud`, `kubectl`, `docker`

### Provisionar Infraestrutura
```bash
cd terraform/
terraform init
terraform apply -auto-approve
```

### Aplicar Manifests Kubernetes
```bash
kubectl apply -f k8s/k8s-banco/
kubectl apply -f k8s/k8s-grafana/
kubectl apply -f k8s/k8s-prometheus/
kubectl apply -f k8s/k8s-observabilidade/
kubectl apply -f k8s/k8s-ingress-nginx/
```

---

## 🗂 Estrutura Geral do Projeto

```plaintext
Terra_Ansible/
├── .github/workflows/
│   └── pipeInfra.yml               # CI/CD do deploy
├── terraform/
│   ├── main.tf                     # Cluster GKE
│   ├── variables.tf                # Variáveis do projeto
│   ├── outputs.tf                  # Outputs de infraestrutura
│   └── terraform.tfvars            # Configurações reais do cluster
├── k8s/
│   ├── k8s-banco/                  # Postgres: deployment + service
│   ├── k8s-grafana/                # Grafana + service
│   ├── k8s-prometheus/            # Prometheus + service
│   ├── k8s-observabilidade/       # Namespace + Ingress
│   └── k8s-ingress-nginx/         # NGINX ingress controller
```

---

## 🧑‍💻 Créditos e Colaboração

Projeto desenvolvido por alunos do 6º período — Engenharia de Software:

| Nome                                  | GitHub                                  |
|---------------------------------------|------------------------------------------|
| Emilio Anastácio de Paula Correa      | [@EmilioAnastacio](https://github.com/EmilioAnastacio) |
| Hisham Espier                         | [@heshamgamer2015](https://github.com/heshamgamer2015) |
| Josué Antonio Gardasz Obadovski       | [@JosueObadovski](https://github.com/JosueObadovski) |
| Arthur Henrique Busanello             | [@Arthur-Busanello09](https://github.com/Arthur-Busanello09) |
| Maria Eduarda Damo da Costa           | [@mriaxb](https://github.com/mriaxb) |

---

📁 Repositório:  
https://github.com/Mamutes-Pequenos/Terra_Ansible/tree/developer4
