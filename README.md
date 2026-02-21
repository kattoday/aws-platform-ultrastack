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


# 🚀 UltraStack: Enterprise-Grade AWS ECS Platform

A fully automated, GitOps-driven infrastructure platform built with **Terraform**, **AWS**, and **GitHub Actions**.

## 🏗️ Architecture Overview
This project deploys a high-availability container environment in the `eu-west-2` (London) region.

* **Networking:** Custom VPC (`10.0.0.0/16`) with Public and Private subnets across two Availability Zones.
* **Compute:** AWS ECS Fargate (Serverless) running containerized Nginx.
* **Load Balancing:** Application Load Balancer (ALB) acting as the entry point.
* **Security:** Security Group nesting (ALB -> ECS) and keyless OIDC authentication for CI/CD.
* **Observability:** Centralized logging via Amazon CloudWatch.

## 🛠 Tech Stack
- **IaC:** Terraform v1.10+
- **CI/CD:** GitHub Actions (OIDC)
- **Cloud:** AWS (VPC, ECS, ALB, IAM, S3, DynamoDB)
- **Monitoring:** CloudWatch Logs

## 🚀 Deployment Pipeline
Every push to the `main` branch triggers a GitHub Action that:
1.  Authenticates to AWS via OIDC (No secret keys stored!).
2.  Initializes Terraform with an S3 remote backend.
3.  Plans and applies the infrastructure changes automatically.

## 📈 Observability
Application logs are streamed directly to CloudWatch, allowing for real-time monitoring of:
- Load Balancer Health Checks.
- HTTP Request/Response codes.
- Container system output.

---
*Created as part of a Cloud Engineering immersion project.*

