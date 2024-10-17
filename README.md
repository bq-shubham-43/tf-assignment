
# Terraform GCP Infrastructure Setup

This repository contains Terraform configurations for creating a robust infrastructure on Google Cloud Platform (GCP). The configuration includes setting up Virtual Private Clouds (VPCs), Managed Instance Groups (MIGs), HTTP Load Balancers, Internal Load Balancers (ILBs), and VPC Peering between networks.

## Overview

This project deploys the following infrastructure components:

- **VPC Networks:** Two custom VPCs with subnets and firewall rules.
- **Managed Instance Groups (MIGs):** Two MIGs, one in each VPC, to manage instances in an automated fashion.
- **HTTP Load Balancer:** An HTTP load balancer that routes traffic between the MIGs.
- **Internal Load Balancers (ILBs):** Two internal load balancers, one for each VPC, to manage internal traffic.
- **VPC Peering:** Peering between the two VPC networks to enable communication between them.

## Project Structure

```bash
├── modules
│   ├── vpc
│   ├── mig
│   ├── http_lb
│   ├── internal_lb
│   └── vpc_peering
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

### Modules

- **VPC Module:** Configures VPCs with subnets and firewall rules.
- **MIG Module:** Configures Managed Instance Groups with autoscaling and instance templates.
- **HTTP Load Balancer Module:** Configures the global HTTP load balancer that forwards traffic to the MIGs.
- **Internal Load Balancer Module:** Configures regional internal load balancers for each VPC.
- **VPC Peering Module:** Configures VPC peering between two VPCs for internal communication.

## Prerequisites

Before you begin, ensure you have the following:

- [Terraform](https://www.terraform.io/downloads) installed.
- Google Cloud SDK (`gcloud`) configured.
- A GCP project with appropriate IAM permissions for deploying resources.

## Usage

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/your-repository.git
   cd your-repository
   ```

2. **Initialize Terraform:**

   Run the following command to initialize the Terraform configuration and download the necessary providers:

   ```bash
   terraform init
   ```

3. **Configure variables:**

   Modify the `variables.tf` file or create a `terraform.tfvars` file to set values for your environment:

   ```hcl
   project_id = "your-gcp-project-id"
   region     = "us-central1"
   zone       = "us-central1-a"
   ```

4. **Plan the infrastructure:**

   Run the following command to view the infrastructure plan:

   ```bash
   terraform plan
   ```

5. **Apply the configuration:**

   Apply the Terraform configuration to provision the resources:

   ```bash
   terraform apply
   ```

6. **Destroy the infrastructure:**

   If you need to tear down the infrastructure, run:

   ```bash
   terraform destroy
   ```

## Files Description

### `main.tf`

This file defines the root module for the infrastructure, calling submodules to provision the resources.

### `variables.tf`

Contains the variable definitions used across the configuration, such as project ID, region, and VPC settings.

### `outputs.tf`

Defines the outputs of the Terraform configuration, such as the instance group URLs and load balancer IP addresses.

### Modules

Each module has its own `main.tf`, `variables.tf`, and `outputs.tf` files to define its specific resources and outputs.
