#!/bin/bash

echo "📸 Capturing project evidence for LinkedIn..."
echo ""

echo "1. Cluster information..."
kubectl cluster-info > evidence/cluster-info.txt

echo "2. All pods..."
kubectl get pods --all-namespaces -o wide > evidence/all-pods.txt

echo "3. All services..."
kubectl get svc --all-namespaces > evidence/all-services.txt

echo "4. Production HPA..."
kubectl get hpa -A > evidence/hpa.txt

echo "5. ArgoCD status..."
kubectl get applications -n argocd 2>/dev/null > evidence/argocd-apps.txt || echo "ArgoCD apps not configured" > evidence/argocd-apps.txt

echo "6. Project structure..."
find . -type f \( -name "*.yaml" -o -name "*.yml" -o -name "*.sh" -o -name "*.md" \) | sort > evidence/project-files.txt

echo "7. Creating summary..."
cat > evidence/PROJECT_SUMMARY.txt << SUMMARY
PRODUCTION-GRADE DEVOPS PROJECT EVIDENCE
=========================================
Date: $(date)
Cluster: $(kubectl cluster-info | head -1)

DEPLOYED COMPONENTS:
• Frontend Web Application (Nginx)
• Backend API Service
• Redis Cache
• Staging Environment
• Production Environment
• Monitoring Stack (Prometheus + Grafana)
• ArgoCD GitOps Controller
• Horizontal Pod Autoscaling

FEATURES DEMONSTRATED:
✓ Multi-environment deployment
✓ GitOps methodology
✓ Production monitoring
✓ Auto-scaling configuration
✓ Health checks & probes
✓ Resource management
✓ Service discovery
✓ Configuration management

ACCESS URLs:
• Staging Frontend: http://localhost:8080
• Production Frontend: http://localhost:8082
• Staging Backend: http://localhost:8081
• Production Backend: http://localhost:8083
• ArgoCD UI: https://localhost:8443
• Prometheus: http://localhost:9090
• Grafana: http://localhost:3000

TECHNOLOGY STACK:
• Kubernetes
• ArgoCD
• Prometheus
• Grafana
• Docker
• Kustomize
• Helm
SUMMARY

echo "✅ Evidence captured in evidence/ directory"
echo ""
echo "Files created:"
ls -la evidence/
echo ""
echo "Use these files for your LinkedIn post and CV!"
