# Terra_Ansible · Provisionamento de Infraestrutura com Terraform, Kubernetes e Observabilidade

Repositório de infraestrutura como código voltado à criação de ambientes isolados de homologação e produção na Google Cloud Platform, utilizando Google Kubernetes Engine (GKE), gerenciamento automatizado com Terraform e integração contínua via GitHub Actions. A observabilidade é implementada com Prometheus e Grafana, expostos por NGINX Ingress Controller.

---

## Diagrama de Arquitetura

> Imagem do diagrama será inserida aqui assim que estiver hospedada.  
> Substituir este texto pelo link direto da imagem PNG com a arquitetura do projeto.

---

## Sumário

1. Visão Geral  
2. Objetivo da Entrega  
3. Ambientes e Estrutura  
4. Tecnologias Utilizadas  
5. Infraestrutura Provisionada  
6. CI/CD com GitHub Actions  
7. Observabilidade  
8. Execução Local  
9. Estrutura do Repositório  
10. Equipe  

---

## Visão Geral

Este projeto provê o provisionamento completo de ambientes Kubernetes na nuvem pública com separação lógica por namespace e automação de deploys através de pipelines GitHub Actions. A monitoração do ambiente é realizada com Prometheus e Grafana, acessíveis via Ingress Controller.

---

## Objetivo da Entrega

- Provisionar um cluster Kubernetes com dois ambientes lógicos: Staging e Produção.
- Automatizar o processo de deploy com GitHub Actions.
- Disponibilizar Prometheus e Grafana para monitoramento de recursos.
- Controlar acesso aos dashboards via Ingress com caminhos definidos.
- Manter estrutura modular, declarativa e reprodutível com Terraform e YAMLs.

---

## Ambientes e Estrutura

| Ambiente  | Cluster             | Namespaces                   | Exposição via Ingress        |
|-----------|---------------------|-------------------------------|-------------------------------|
| Staging   | gke-cluster-homol   | observabilidade, dbnamespace | /grafana e /prometheus        |

---

## Tecnologias Utilizadas

| Ferramenta       | Função                                         |
|------------------|------------------------------------------------|
| Terraform        | Infraestrutura como código (IaC)               |
| Kubernetes (GKE) | Orquestração de containers                     |
| Docker           | Criação e empacotamento de imagens             |
| GitHub Actions   | Integração e entrega contínua (CI/CD)          |
| Prometheus       | Coleta de métricas do cluster e serviços       |
| Grafana          | Visualização das métricas em dashboards        |
| NGINX Ingress    | Roteamento HTTP interno por caminho (path)     |

---

## Infraestrutura Provisionada

- Cluster GKE criado via Terraform com 2 nós padrão `e2-medium`.
- Banco PostgreSQL implantado com Service do tipo `ClusterIP`.
- Prometheus e Grafana implantados em namespace isolado.
- Ingress Controller responsável pelo roteamento de `/grafana` e `/prometheus`.
- Deploys e serviços organizados por diretórios com arquivos YAML.

---

## CI/CD com GitHub Actions

O pipeline está localizado no arquivo `.github/workflows/pipeInfra.yml`.

### Etapas do pipeline:

1. Clone do repositório.
2. Decodificação e ativação da conta de serviço GCP.
3. Execução dos comandos `terraform init` e `terraform apply`.
4. Autenticação no cluster com `gcloud` e configuração de credenciais.
5. Aplicação de namespaces e deploys com `kubectl`.
6. Instalação do Ingress Controller.
7. Aplicação das regras de Ingress para rotas HTTP.
8. Validação da criação dos recursos.

---

## Observabilidade

- O namespace `observabilidade` contém os pods de Prometheus e Grafana.
- Ambos os serviços estão expostos via Ingress com rotas:
  - `/grafana` para o dashboard
  - `/prometheus` para a consulta de métricas
- O Ingress utiliza anotações compatíveis com o controller NGINX.

---

## Execução Local

### Pré-requisitos

- Conta na GCP com permissão para criar clusters.
- Ferramentas instaladas localmente:
  - Terraform
  - GCloud SDK
  - Kubectl
  - Docker

### Comandos

```bash
cd terraform/
terraform init
terraform apply -auto-approve
```

```bash
kubectl apply -f k8s/k8s-prometheus/
kubectl apply -f k8s/k8s-grafana/
kubectl apply -f k8s/k8s-banco/
kubectl apply -f k8s/k8s-observabilidade/
kubectl apply -f k8s/k8s-ingress-nginx/
```

---

## Estrutura do Repositório

```
Terra_Ansible/
├── .github/workflows/
│   └── pipeInfra.yml
├── terraform/
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   └── variables.tf
├── k8s/
│   ├── k8s-banco/
│   ├── k8s-grafana/
│   ├── k8s-prometheus/
│   ├── k8s-observabilidade/
│   └── k8s-ingress-nginx/
```

---

## Equipe

| Nome                                   | GitHub                                      |
|----------------------------------------|---------------------------------------------|
| Emilio Anastácio de Paula Correa       | https://github.com/EmilioAnastacio          |
| Hisham Espier                          | https://github.com/heshamgamer2015          |
| Josué Antonio Gardasz Obadovski        | https://github.com/JosueObadovski           |
| Arthur Henrique Busanello              | https://github.com/Arthur-Busanello09       |
| Maria Eduarda Damo da Costa            | https://github.com/mriaxb                   |

---

Repositório oficial:  
https://github.com/Mamutes-Pequenos/Terra_Ansible/tree/developer4
