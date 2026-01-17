#!/bin/bash

echo "🔍 Running health checks..."

check_service() {
    local service=$1
    local namespace=$2
    local port=$3
    
    echo "Checking $service in $namespace..."
    
    if kubectl get pods -n $namespace -l app=$service | grep -q Running; then
        echo "✓ $service pods are running"
        
        # Get service IP
        local service_ip=$(kubectl get svc -n $namespace ${service}-service -o jsonpath='{.spec.clusterIP}')
        
        # Check connectivity
        if kubectl run -n $namespace --rm -i --restart=Never --image=busybox test-$service -- \
           wget -qO- --timeout=5 http://${service}-service.$namespace:${port} > /dev/null 2>&1; then
            echo "✓ $service is reachable"
            return 0
        else
            echo "✗ $service is not reachable"
            return 1
        fi
    else
        echo "✗ $service pods are not running"
        return 1
    fi
}

# Check staging services
echo "--- Staging Environment ---"
check_service frontend staging 80
check_service backend staging 3000
check_service redis staging 6379

# Check production services
echo -e "\n--- Production Environment ---"
check_service frontend production 80
check_service backend production 3000
check_service redis production 6379

echo -e "\n📊 Resource Usage:"
kubectl top pods --all-namespaces | head -20

echo -e "\n✅ Health check completed!"
