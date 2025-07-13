# 🚀 DevOps for Flutter Food Ordering App (food_heaven)

This project demonstrates the complete DevOps pipeline and deployment process for a Flutter-based food ordering web application named **food_heaven**.

---

## 📌 Overview

A modern food ordering app built with Flutter Web, integrated with a full CI/CD pipeline using GitHub Actions. The application is containerized with Docker and deployed on **Amazon ECS (Fargate)** using **Amazon ECR Public Registry**.

---

## 🧰 Tech Stack

| Category               | Tools/Services                         |
|------------------------|----------------------------------------|
| **Frontend**           | Flutter Web                            |
| **CI/CD**              | GitHub Actions                         |
| **Containerization**   | Docker                                 |
| **Image Registry**     | Amazon ECR (Public)                    |
| **Deployment**         | Amazon ECS (Fargate)                   |
| **Secrets Management** | AWS Secrets Manager                    |

---

## ⚙️ CI/CD Workflow

1. Push to `main` branch triggers the GitHub Actions workflow.
2. Flutter web app is built using `flutter build web`.
3. Docker image is built and pushed to Amazon ECR Public Registry.
4. ECS (Fargate) is updated with the latest image for zero-downtime deployment.

---

## 🛠️ Repository Details

- **Repository Name**: `food-heaven`
- **Public ECR URI**: `public.ecr.aws/c0t2e3x3/food-heaven`
- **Created**: June 24, 2025

---

## 📤 ECR Push Commands

```bash
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/c0t2e3x3

docker build -t food-heaven .
docker tag food-heaven:latest public.ecr.aws/c0t2e3x3/food-heaven:latest
docker push public.ecr.aws/c0t2e3x3/food-heaven:latest
