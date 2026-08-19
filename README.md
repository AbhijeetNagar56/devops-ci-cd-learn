# DevOps CI/CD Pipelines & GitOps Lab

A practical repository demonstrating modern **Continuous Integration (CI)** and **Continuous Delivery/Deployment (CD)** pipelines. This project covers containerizing source code, publishing images to registries, automating application deployments, and managing infrastructure using **GitOps**.

---

## 🛠️ Tools & Technologies Covered

* **CI/CD Platforms:** GitHub Actions, Jenkins
* **GitOps & Delivery:** ArgoCD
* **Containerization & Registry:** Docker, GitHub Container Registry (`ghcr.io`)
* **Deployment Targets:** Render VPS, Kubernetes Clusters

---

## 🏗️ End-to-End Pipeline Overview

### 3-Tier Application Deployment Flow
```

               ┌─── [ Job: Test & Build Backend ]  ───► Push Image ───┐
── Git Push ───┤                                                      ├───► [ Job: Deploy hook Render ]
               └─── [ Job: Test & Build Frontend ] ───► Push Image ───┘
```
