# CampusEase Terraform Infrastructure

This repository contains the Terraform configuration files to provision and manage the cloud-native infrastructure for CampuEase, an automated scalable application platform deployed on AWS.

## Overview

The Terraform setup automates provisioning of core AWS resources needed to run CampuEase, including:

- VPC, subnet, and network configuration with peering setups
- Security groups for controlled access to services and nodes
- EKS cluster and managed node groups for Kubernetes container orchestration
- RDS MySQL database deployment for transactional data
- Bastion hosts for secure administrative access
- Application Load Balancers (ALB) for ingress and HTTPS termination
- ACM certificates and Route53 DNS records for secure, managed domain access
- ECR repositories for Docker container image storage
- Parameter Store integration for centralized configuration management

The configurations are modularized and follow infrastructure as code best practices, enabling repeatable, auditable, and scalable deployments.

## Modules and Folder Structure

- `10-networking`: VPC, public/private subnet configuration, peering
- `20-bastion`: Bastion host setup with Docker and Kubernetes CLI tooling
- `30-db`: RDS MySQL instance and subnet group provisioning
- `40-eks`: EKS cluster, node groups, Kubernetes addon management
- `50-acm`: ACM certificates and DNS validation automation
- `60-ingress-alb`: Application Load Balancer and Listener configuration
- `70-ecr`: Elastic Container Registry for backend and frontend images

## Getting Started

1. Ensure AWS CLI credentials and permissions are configured for Terraform.
2. Update variables in respective `variables.tf` files for your environment and naming conventions.
3. Initialize Terraform modules:
    ```
    terraform init
    ```
4. Review and apply infrastructure configuration:
    ```
    terraform apply
    ```
5. Use the deployed resources for application deployment, scaling, and management.

## Project Context

CampusEase is designed to provide a scalable, secure foundation for containerized applications in AWS cloud environments. It leverages Kubernetes with managed node groups, persistent MySQL data, and secure ingress with ACM TLS certificates. The setup enables continuous integration and deployment workflows using Jenkins pipelines (outside scope here).

## Prerequisites

- AWS account with adequate permissions
- Terraform CLI installed (version 1.x+ recommended)
- SSH keys configured for EC2 access and EKS node authentication
- Domain name configured in Route53 for ACM and ALB integrations

## Notes

- Terraform state is managed in an S3 bucket with locking enabled for team collaboration.
- Sensitive data like DB passwords are managed securely; master user password management is disabled here for demo purposes.
- Adjust resource sizes and scaling parameters in modules to match production workloads.

