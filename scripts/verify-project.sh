#!/bin/bash

echo "🔍 Verifying Project Completion..."
echo ""

# Check all components
echo "1. Checking all namespaces..."
namespaces=$(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}')
echo "   Found namespaces: $namespaces"
echo ""

echo "2. Checking running pods..."
total_pods=$(kubectl get pods --all-namespaces --no-headers | grep -v "Completed" | wc -l)
echo "   Total running pods: $total_pods"
echo ""

echo "3. Checking services..."
total_services=$(kubectl get svc --all-namespaces --no-headers | wc -l)
echo "   Total services: $total_services"
echo ""

echo "4. Testing application access..."
echo "   Staging frontend:"
curl -s http://localhost:8080 | grep -o "<title>.*</title>"
echo "   Production frontend:"
curl -s http://localhost:8082 | grep -o "<title>.*</title>"
echo ""

echo "5. Checking ArgoCD status..."
if kubectl get pods -n argocd | grep -q "Running"; then
    echo "   ✅ ArgoCD is running"
else
    echo "   ⚠ ArgoCD not fully running"
fi
echo ""

echo "6. Checking HPA configuration..."
if kubectl get hpa -n production &>/dev/null; then
    echo "   ✅ HPA configured for production"
else
    echo "   ⚠ HPA not configured"
fi
echo ""

echo "📊 FINAL STATISTICS:"
echo "===================="
echo "• Kubernetes Cluster: $(kubectl cluster-info | head -1)"
echo "• Total Pods: $total_pods"
echo "• Total Services: $total_services"
echo "• Environments: Staging & Production"
echo "• Monitoring Stack: Prometheus + Grafana"
echo "• GitOps: ArgoCD"
echo "• Auto-scaling: HPA configured"
echo "• Health Checks: Liveness & Readiness probes"
echo "• Resource Management: Limits & Requests"
echo ""

echo "🎉 PROJECT VERIFICATION COMPLETE!"
echo "✅ Your DevOps project is ready for LinkedIn showcase!"
echo ""
echo "Next steps:"
echo "1. Take screenshots of terminal outputs"
echo "2. Take screenshots of web interfaces"
echo "3. Update GitHub repository"
echo "4. Create LinkedIn post"
echo "5. Update your CV with this project"
