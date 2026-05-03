# Terraform Snowflake RBAC Automation

![Terraform](https://img.shields.io/badge/Terraform-623CE4?style=for-the-badge&logo=terraform&logoColor=ffffff)
![Snowflake](https://img.shields.io/badge/Snowflake-0099FF?style=for-the-badge&logo=snowflake&logoColor=ffffff)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=ffffff)
![VS Code](https://img.shields.io/badge/VS%20Code-007ACC?style=for-the-badge&logo=visual-studio-code&logoColor=ffffff)
![IaC](https://img.shields.io/badge/Infrastructure%20as%20Code-2F2F2F?style=for-the-badge&logo=terraform&logoColor=ffffff)
![RBAC](https://img.shields.io/badge/RBAC-FF6F61?style=for-the-badge&logoColor=ffffff)

---

## 📌 Overview

This repository implements a **production-grade Infrastructure as Code (IaC) solution** for managing **Snowflake Role-Based Access Control (RBAC)** using **Terraform**.

It replaces manual Snowflake administration with a **declarative, version-controlled, and auditable access management system**, enabling consistent security enforcement across multiple environments such as development, staging, and production.

The solution is designed for **data engineers, analytics engineers, and platform teams** who require scalable, secure, and compliant access governance in Snowflake.

---

## 🎯 Objectives

- Standardize Snowflake user, role, and privilege management
- Enforce least-privilege access by design
- Reduce operational overhead and human error
- Enable auditability and compliance through Git version control
- Support multi-environment deployments with minimal duplication

---


## ✨ Key Features

### 🔹 Automated User Lifecycle Management
Users are created, updated, and decommissioned declaratively using Terraform, ensuring Snowflake access always reflects the desired state.

### 🔹 Role-Based Access Control (RBAC)
Clearly defined roles aligned with organizational responsibilities, reducing over-privileged access.

### 🔹 Fine-Grained Grant Management
Explicit control over database, schema, warehouse, and object-level privileges following the principle of least privilege.

### 🔹 Modular Architecture
Reusable Terraform modules separate concerns for users, roles, and grants, improving maintainability and scalability.

### 🔹 Multi-Environment Support
Environment-specific configurations allow safe promotion of changes from development to production.

### 🔹 Version-Controlled Security
All access changes are tracked through Git, providing a transparent audit trail.

---


## 📊 Business Impact

- **Reduced Operational Overhead**: Eliminates manual Snowflake access provisioning.  
- **Improved Security Posture**: Enforces least-privilege access by design.  
- **Audit & Compliance Ready**: All access changes are traceable through Git history.  
- **Scalable Governance**: Supports growing teams, projects, and environments without added complexity.


---

## 🔒 Security Considerations

- **Sensitive credentials are never committed** to the repository.  
- **Access is granted explicitly** and reviewed via Terraform plans before application.  
- **Changes are peer-reviewable** through pull requests.  
- **Terraform state acts as a single source of truth** for Snowflake access configuration.  

---

## 🛠️ Technology Stack

- **Terraform** – Declarative Infrastructure as Code
- **Snowflake** – Cloud-native data platform
- **Git / GitHub** – Source control and collaboration
- **VS Code** – Development environment

---




## 📁 Repository Structure

```text
Terraform-Snowflake-RBAC-Automation/
├── modules/
│   ├── users/            # Snowflake user management
│   ├── roles/            # Role definitions and hierarchy
│   └── grants/           # Privilege assignments

├── provider.tf           # Snowflake provider configuration
├── variables.tf          # Global input variables
├── outputs.tf            # Exposed outputs
└── README.md             # Documentation
```

## 🚀 Getting Started

### Prerequisites

- Terraform >= 1.x
- Snowflake account with appropriate administrative privileges
- Snowflake credentials configured via environment variables or a secure secrets manager

### Deployment Steps

```bash
# Clone the repository
git clone https://github.com/007ekho/Terraform-Snowflake-RBAC-Automation.git
cd Terraform-Snowflake-RBAC-Automation

# Select target environment
cd environments/dev

#Initialize creadentials 
export SNOWFLAKE_ORGANIZATION="ORGNAME"
export SNOWFLAKE_ACCOUNT="ACCOUNTNAME"
export SNOWFLAKE_USER="your-username"
export SNOWFLAKE_PASSWORD="your-password"
export SNOWFLAKE_ROLE="ACCOUNTADMIN"  # Optional

# Initialize Terraform (downloads providers and modules)
terraform init

# Review planned changes
terraform plan

# Apply configuration
terraform apply

```

## 👤 Author

**Success Ekhosuehi**  
GitHub: https://github.com/007ekho
LinkedIn: https://www.linkedin.com/in/suehi/







# CI/CD Test v3 - Fixed workflow path
