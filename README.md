# AWS UltraStack: Automated ECS Fargate Platform

A production-grade, highly-available container orchestration platform built with **Terraform** and **GitHub Actions**. This project demonstrates "GitOps" principles, where infrastructure is managed entirely through code and automated pipelines.

## 🚀 Key Features
* **Zero-Trust Networking:** Custom VPC with isolated public/private subnets and security group nesting.
* **Serverless Compute:** ECS Fargate cluster running containerized workloads without the overhead of managing EC2 instances.
* **Modern CI/CD:** Fully automated deployment pipeline using **GitHub Actions** and **OpenID Connect (OIDC)** for keyless AWS authentication.
* **State Management:** Remote state storage using **Amazon S3** with state locking via **DynamoDB**.
* **Observability:** Integrated **CloudWatch Logging** for real-time application monitoring.

## 🏗️ Architecture


## 🛠️ Tech Stack
- **IaC:** Terraform
- **Cloud:** AWS (VPC, ECS, ALB, IAM, S3, DynamoDB, CloudWatch)
- **CI/CD:** GitHub Actions
- **Containerization:** Docker (Nginx)

## 📋 How to Deploy
1. **Prerequisites:** AWS Account, GitHub Account, and Terraform installed.
2. **Backend Setup:** Manually create an S3 bucket and DynamoDB table for Terraform state.
3. **Identity:** Configure AWS IAM OIDC provider for GitHub Actions.
4. **Deploy:** Push changes to the `main` branch to trigger the automated deployment.

## 🔍 Lessons Learned
- **Security First:** Implemented OIDC to eliminate the need for long-lived IAM Access Keys.
- **Scalability:** Designed the network across multiple Availability Zones (Multi-AZ) to ensure high availability.
- **Observability:** Configured the `awslogs` driver to ensure application health can be monitored without SSH access.

