# Infrastructure as Code (IaC)

## Overview

This project provisions a complete Azure Hub-Spoke architecture using Terraform modular design.

The infrastructure is designed to follow enterprise standards with:
* Reusable Terraform modules
* Multi-environment support (Dev/UAT/Prod)
* Hub-Spoke networking model
* Centralized security using Azure Firewall
* Private backend workloads
* Application Gateway integration
* Azure Key Vault integration
* End-to-end infrastructure automation

---

# Architecture

## Inbound Web Flow

Internet --> AGW Public IP --> AGW Backend Pool --> Private IIS VM

## RDP Flow

Internet --> Firewall Public IP --> DNAT Rule --> Private VM

# Hub-Spoke Network Design

## Hub VNet

Purpose:

* Centralized connectivity
* Shared security services
* Ingress traffic management

Address Space: 10.48.0.0/16

### Hub Subnets

| Subnet              | CIDR         | Purpose             |
| ------------------- | ------------ | ------------------- |
| AzureFirewallSubnet | 10.48.1.0/24 | Azure Firewall      |
| agw-subnet          | 10.48.2.0/24 | Application Gateway |

---

## Spoke VNet

Purpose:

* Hosts application workloads
* Isolated backend resources

Address Space: 10.49.0.0/16

### Spoke Subnets

| Subnet     | CIDR         | Purpose          |
| ---------- | ------------ | ---------------- |
| web-subnet | 10.49.1.0/24 | Web VM           |
| app-subnet | 10.49.2.0/24 | Application Tier |
| db-subnet  | 10.49.3.0/24 | Database Tier    |

---

# Implemented Azure Components

## Networking
* Resource Groups
* Virtual Networks
* Subnets
* NSGs
* NSG Rules
* Route Tables
* Routes (UDRs)
* Route Table Associations
* VNet Peering

---

## Security

### Azure Firewall
Used for:
* Centralized outbound internet control
* DNAT-based RDP access
* Network filtering
* Application filtering

### Firewall Policy
Configured:
* Network Rule Collections
* Application Rule Collections
* NAT Rule Collections

---

## Application Gateway
Configured with:
* Public Frontend IP
* Backend Pool
* HTTP Listener
* Health Probes
* Backend HTTP Settings
* Routing Rules

Purpose:
* Secure web traffic entry point
* Load balancing
* Backend health monitoring

---

## Virtual Machines

### Windows VM
Features:
* Private IP only
* No Public IP
* IIS installed automatically
* RDP via Azure Firewall DNAT

---

## Azure Key Vault
Used to securely store:
* VM admin username
* VM admin password

Terraform retrieves secrets dynamically during deployment.

---

# Deployment Steps

## Initialize Terraform

terraform init -backend-config=./backend/dev.hcl

---

## Validate

terraform validate

---

## Plan

terraform plan -var-file=environments/dev.tfvars

---

## Apply

terraform apply -var-file=environments/dev.tfvars

---

# Validation Performed

## Successfully Validated

* IIS installation
* Application Gateway backend health
* End-to-end web access
* RDP access via Firewall DNAT
* NSG communication
* VNet peering
* Firewall routing
* Key Vault integration

---

# Author

Rajasekhar
DevOps Engineer
