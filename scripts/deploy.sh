#!/bin/bash
set -e

echo "🚀 Starting deployment pipeline..."

ENVIRONMENT=${1:-staging}
VERSION=${2:-1.0.0}
IMAGE_TAG=${3:-latest}

echo "Deploying to: $ENVIRONMENT"
echo "Version: $VERSION"
echo "Image Tag: $IMAGE_TAG"

# Simulate build process
echo "📦 Building application..."
sleep 2

# Simulate tests
echo "🧪 Running tests..."
echo "✓ Unit tests passed"
echo "✓ Integration tests passed"
echo "✓ Security scan passed"

# Simulate container build and push
echo "🐳 Building Docker image..."
echo "✓ Image built: myapp:$VERSION-$IMAGE_TAG"
echo "✓ Image pushed to registry"

# Update deployment (simulated GitOps)
echo "🔄 Updating Git repository for ArgoCD sync..."
echo "✓ Updated image tag in overlays/$ENVIRONMENT/kustomization.yaml"
echo "✓ Committed changes"
echo "✓ Pushed to main branch"

# Wait for ArgoCD sync
echo "⏳ Waiting for ArgoCD to sync..."
sleep 5

echo "✅ Deployment to $ENVIRONMENT completed successfully!"
