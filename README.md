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

Deployment flow:

Git commit → Argo CD sync → Kubernetes reconciliation → Live environment
