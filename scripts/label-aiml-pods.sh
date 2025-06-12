#!/bin/bash

echo "🔍 Scanning all pods for AI/ML image patterns (tensorflow, torch, ml, inference, gpu)..."

# Keywords to look for in container images
PATTERN="tensorflow|torch|ml|inference|gpu"

# Loop through all pods in all namespaces
kubectl get pods --all-namespaces -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name --no-headers | while read namespace pod; do
  # Get container image names for this pod
  IMAGES=$(kubectl get pod "$pod" -n "$namespace" -o jsonpath="{.spec.containers[*].image}" 2>/dev/null)

  # Check if any image name matches the pattern
  echo "$IMAGES" | grep -Eiq "$PATTERN"
  if [ $? -eq 0 ]; then
    echo "🏷 Labeling pod $pod in namespace $namespace"
    kubectl label pod "$pod" app=ai-ml -n "$namespace" --overwrite
  fi
done

echo "✅ Done! Labeled matching AI/ML pods with app=ai-ml"
