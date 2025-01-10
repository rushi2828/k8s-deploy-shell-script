# k8s-deploy-shell-script

This repository contains a shell script (`deploy_app.sh`) designed to streamline application deployment and monitoring for DevOps and SRE workflows. It automates tasks like building Docker images, deploying applications to Kubernetes, and performing health checks.

## ✨ Features
- **Prerequisites Check**: Ensures all required tools (Docker, Kubernetes, and Curl) are installed.
- **Docker Build and Push**: Automates building and pushing Docker images to a container registry.
- **Kubernetes Deployment**: Deploys the application using a Kubernetes manifest file.
- **Health Check**: Verifies the application’s health using an HTTP endpoint.
- **Alert Notifications**: Sends an email alert if the application fails the health check.

---

## 🛠 Prerequisites
Before using this script, ensure the following tools are installed on your system:
- [Docker](https://docs.docker.com/get-docker/)
- [Kubernetes (kubectl)](https://kubernetes.io/docs/tasks/tools/)
- [Curl](https://curl.se/download.html)
- [Mail Utility](https://linux.die.net/man/1/mail) (for sending alerts)

---

## 🚀 How to Use

### 1. Clone the Repository
```
git clone https://github.com/rushi2828/k8s-deploy-shell-script
cd k8s-deploy-shell-script
```
### 2. Configure the Script

##### Update the variables at the top of the script:**

- **APP_NAME:** Name of your application. (```pet-clinic-demo```)
- **DOCKER_IMAGE:** Docker image name (```rushi2323/pet-clinic-demo:latest```).
- **NAMESPACE:** Kubernetes namespace for deployment.(```test```)
- **K8S_DEPLOYMENT_FILE:** Path to your Kubernetes deployment manifest file.(```./k8s-deployment.yaml```)
- **HEALTH_CHECK_URL:** URL of your application’s health check endpoint.(```http://localhost:8085/health```)
- **ALERT_EMAIL:** Email address to send health check alerts.(```rushimane2606@gmail.com```)

## 3. Make the Script Executable
```
chmod +x deploy_app.sh
```
## 4. Run the Script
```
./deploy_app.sh
```

## Script Workflow

##### 1. Prerequisites Check: Ensures kubectl, docker, and curl are installed.
##### 2. Build and Push Docker Image:
- Builds a Docker image from the current directory.
- Pushes the image to the specified Docker repository.
##### 3. Deploy to Kubernetes:
- Applies the Kubernetes deployment manifest.
##### 4. Perform Health Check:
- Sends an HTTP request to the health check endpoint.
- If the endpoint returns a status other than **200**, sends an alert email.
