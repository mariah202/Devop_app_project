
# 🚀 DevOps Pipeline for a Django App with CI/CD to Kubernetes on AWS

## 📌 Project Overview

This project implements a complete DevOps pipeline to deploy a Django-based web application using CI/CD automation. The infrastructure is managed using:

- **Vagrant** for local development
- **Docker** for containerization
- **Jenkins** for automation
- **Kubernetes** for orchestration
- **AWS EC2** for cloud hosting

The Django app renders a modern landing page using the **Spectral** HTML5UP template.

---

## 📆 Timeline Overview

### 🔹 Day 1: Local Development & Containerization
- Setup local development environment with **Vagrant** and **provisioning scripts**
- Scaffold a new **Django** app and integrate **Spectral** HTML5UP template
- Containerize the app using **Docker**
- Push source code to **GitHub**
- Push image to **DockerHub**

### 🔹 Day 2: CI/CD Integration
- Provision **AWS EC2** instance and install tools
- Setup **Jenkins** for automated CI/CD
- Create and use a **Jenkinsfile** for automation
- Prepare **Kubernetes YAML files** for Day 3

### 🔹 Day 3: Kubernetes Deployment & Monitoring
- Deploy app on **Kubernetes**
- Test the pipeline
- Clean up resources and gather screenshots

---

## 🧱 Tech Stack

| Tool            | Purpose                               |
|-----------------|----------------------------------------|
| Django          | Web framework                         |
| Vagrant         | Local virtual machine setup           |
| Docker          | Containerization                      |
| Git + GitHub    | Version control and source repository |
| DockerHub       | Container registry                    |
| Jenkins         | CI/CD pipeline automation             |
| AWS EC2         | Cloud hosting                         |
| Kubernetes      | Container orchestration               |
| Bash/YAML/JSON  | Automation & Configuration            |

---

## 📁 Project Structure

```
devops-django-project/
│
├── app/                    # Django app with Spectral integration
├── Dockerfile              # App Docker configuration
├── docker-compose.yml      # Local dev setup
├── Jenkinsfile             # CI/CD pipeline steps
├── config.json             # App configuration
├── Vagrantfile             # VM definition for local setup
├── provision.sh            # Shell provisioning script
├── k8s/
│   ├── deployment.yaml     # Kubernetes deployment config
│   └── service.yaml        # Kubernetes service config
└── README.md               # Project documentation
```

---

## ✅ Tasks & Deliverables

### ✅ Task 1: Vagrant Local Dev Environment
- Set up Ubuntu VM with `Vagrantfile`
- Provision with `provision.sh` to install:
  - Python, pip, Git, Docker, Docker Compose

### ✅ Task 2: Create Django App (with Spectral Template)
- Scaffold Django app with Spectral landing page
- Configure static files: CSS, JS, images
- Add `requirements.txt`, `.gitignore`
- Root URL serves Spectral index page

### ✅ Task 3: Dockerize the Django App
- Create `Dockerfile` and `docker-compose.yml`

### ✅ Task 4: Git & GitHub Integration
- Push project to GitHub  
  🔗 [https://github.com/mariah202/Devop_app_project.git](#)

### ✅ Task 5: DockerHub Integration
- Build and push Docker image  
  🔗 [DockerHub Image Link](#)

---

## 🔄 CI/CD Pipeline (Jenkins)

### ✅ Task 6: Provision AWS EC2
- Setup EC2 (Ubuntu)
- Install Docker, Jenkins, kubectl
- Jenkins accessible at:  
  🔗 `http://<ec2-ip>:8080`

### ✅ Task 7: Jenkins Pipeline
- Multibranch pipeline pulling from GitHub
- Jenkinsfile builds Docker image, pushes to DockerHub, deploys to Kubernetes

### ✅ Task 8: Config Files
- `config.json` for app config
- `deployment.yaml`, `service.yaml` for Kubernetes

---

## ☸️ Kubernetes Deployment

### ✅ Task 9: Setup Kubernetes on AWS
- Use minikube/k3s/kind
- Verify with `kubectl get nodes`

### ✅ Task 10: Deploy App
- Apply manifests and expose service

> App URL: `http://<ec2-ip>:<port>/`

### ✅ Task 11: Test CI/CD
- Update Spectral page content
- Push to GitHub and observe Jenkins redeploy

### ✅ Task 12: Monitoring & Cleanup
- View logs, delete deployments and services

---

## 📸 Screenshots & Evidence

| Task | Screenshot |
|------|------------|
| Jenkins on EC2 | ![jenkins-running](screenshots/jenkins.png) |
| Deployed App | ![app-url](screenshots/app.png) |
| kubectl Outputs | ![kubectl-pods](screenshots/kubectl.png) |
| CI/CD Trigger | ![pipeline](screenshots/pipeline.png) |

---

## 📚 Lessons Learned

- Integrated CI/CD pipeline with Jenkins
- Automated Docker + Kubernetes workflows
- Served modern HTML5 template via Django

---

## 📝 Final Submission Checklist

- ✅ GitHub Link: [Insert Link](#)
- ✅ DockerHub Link: [Insert Link](#)
- ✅ EC2 IP/Link: `http://<ec2-ip>:<port>/`
- ✅ Documented steps and screenshots
- ✅ Cleaned and structured repo

---

## 📅 Deadline

🗓️ **Final Submission Date: 12 June 2025**

---

## 🔖 Author

**Name:** _[Your Full Name]_  
**GitHub:** [@yourhandle](#)  
**DockerHub:** [yourdockerhub](#)
