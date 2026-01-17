# Production-Grade E-Commerce Platform with GitOps

##  Project Overview
A complete cloud-native e-commerce platform deployed using GitOps methodology with ArgoCD. Features multi-environment deployment, production monitoring, and automated CI/CD workflows.

##  Architecture
### High-Level Architecture

- GitHub repository serves as the single source of truth
- Argo CD continuously synchronizes Kubernetes cluster state from Git
- Kustomize manages environment overlays (base → production)
- Kubernetes runs containerized frontend and backend services
- Prometheus and Grafana provide observability and monitoring
- Ingress controller exposes services securely

### Architecture Diagram

                ┌──────────────────────────┐
                │        GitHub Repo        │
                │  (Source of Truth - Git)  │
                └────────────┬─────────────┘
                             │
                             │ GitOps Sync
                             ▼
                ┌──────────────────────────┐
                │         Argo CD           │
                │  Continuous Reconciliation│
                └────────────┬─────────────┘
                             │
                             ▼
                ┌──────────────────────────┐
                │      Kubernetes Cluster   │
                │                            │
                │  ┌──────────┐  ┌────────┐│
                │  │ Frontend │  │ Backend││
                │  │  (Nginx) │  │  API   ││
                │  └──────────┘  └────────┘│
                │                            │
                │  Prometheus  →  Grafana    │
                │   Monitoring & Metrics     │
                └────────────┬─────────────┘
                             │
                             ▼
                     Ingress Controller
                             │
                             ▼
                       End Users
### GitOps Deployment Workflow

1. Developer pushes code or configuration to GitHub
2. GitHub repository becomes the single source of truth
3. Argo CD detects changes automatically
4. Kubernetes cluster state is reconciled with Git
5. Monitoring validates application health
6. Rollbacks can be performed via Git revert



Deployment flow:

Git commit → Argo CD sync → Kubernetes reconciliation → Live environment
