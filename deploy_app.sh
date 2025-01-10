#!/bin/bash

# Script to automate application deployment and monitoring
# Author: DevOps Engineer (Update with your name)
# Date: $(date)

# Variables
APP_NAME="pet-clinic-demo"
DOCKER_IMAGE="rushi2323/pet-clinic-demo:latest"
NAMESPACE="test"
K8S_DEPLOYMENT_FILE="k8s-deployment.yaml"
HEALTH_CHECK_URL="http://localhost:8085/health"
ALERT_EMAIL="rushimane2606@gmail.com"

# Function to check prerequisites
check_prerequisites() {
  echo "Checking prerequisites..."
  for cmd in kubectl docker curl; do
    if ! command -v $cmd &> /dev/null; then
      echo "Error: $cmd is not installed. Please install it and try again."
      exit 1
    fi
  done
  echo "All prerequisites are met."
}

# Build and push Docker image
build_and_push_image() {
  echo "Building Docker image..."
  docker build -t $DOCKER_IMAGE .
  if [ $? -ne 0 ]; then
    echo "Error: Docker build failed."
    exit 1
  fi

  echo "Pushing Docker image to repository..."
  docker push $DOCKER_IMAGE
  if [ $? -ne 0 ]; then
    echo "Error: Docker push failed."
    exit 1
  fi
  echo "Docker image built and pushed successfully."
}

# Deploy application to Kubernetes
deploy_to_kubernetes() {
  echo "Deploying application to Kubernetes..."
  kubectl apply -f $K8S_DEPLOYMENT_FILE -n $NAMESPACE
  if [ $? -ne 0 ]; then
    echo "Error: Deployment to Kubernetes failed."
    exit 1
  fi
  echo "Application deployed successfully."
}

# Perform health check
perform_health_check() {
  echo "Performing health check on the application..."
  STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" $HEALTH_CHECK_URL)

  if [ $STATUS_CODE -eq 200 ]; then
    echo "Health check passed. Application is running successfully."
  else
    echo "Health check failed! Sending alert..."
    send_alert
  fi
}

# Send alert
send_alert() {
  echo "Sending alert to $ALERT_EMAIL..."
  echo "Health check failed for $APP_NAME. Please investigate." | mail -s "ALERT: $APP_NAME Health Check Failed" $ALERT_EMAIL
  echo "Alert sent."
}

# Main script execution
main() {
  check_prerequisites
  build_and_push_image
  deploy_to_kubernetes
  perform_health_check
}

# Execute the main function
main
