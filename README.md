# Terraform Snowflake RBAC Automation

![Terraform](https://img.shields.io/badge/Terraform-623CE4?style=for-the-badge&logo=terraform&logoColor=ffffff)
![Snowflake](https://img.shields.io/badge/Snowflake-0099FF?style=for-the-badge&logo=snowflake&logoColor=ffffff)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=ffffff)
![Terraform Cloud](https://img.shields.io/badge/Terraform_Cloud-623CE4?style=for-the-badge&logo=terraform&logoColor=ffffff)
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
Explicit control over database, schema, warehouse, and object-level privileges following the principle of least privilege. Supports:
- Database-level grants
- Schema-level grants
- Specific table and view grants
- Bulk grants on all existing tables in a schema
- Future grants — automatically applied to new tables as they are created

### 🔹 Modular Architecture
Reusable Terraform modules separate concerns for users, roles, grants, and object grants, improving maintainability and scalability.

### 🔹 Multi-Environment Support
Environment-specific `.tfvars` files (`dev`, `staging`, `prod`) allow safe promotion of changes with isolated state per environment via Terraform Cloud workspaces.

### 🔹 CI/CD Pipeline with GitHub Actions
A fully automated pipeline validates, plans, and applies Terraform changes across environments with approval gates, PR commenting, and artifact management.

### 🔹 Remote State Management
Terraform Cloud is used as the remote backend, providing state locking, versioning, and workspace isolation across environments.

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
- **Secrets are managed via GitHub Actions secrets** and injected at runtime.
- **Access is granted explicitly** and reviewed via Terraform plans before application.
- **Changes are peer-reviewable** through pull requests.
- **Terraform Cloud state** acts as a single source of truth with locking to prevent concurrent modifications.

---

## 🛠️ Technology Stack

| Tool | Purpose |
|---|---|
| **Terraform >= 1.0** | Declarative Infrastructure as Code |
| **Snowflake Provider (~> 0.100)** | Snowflake resource management |
| **Terraform Cloud** | Remote state storage and workspace isolation |
| **GitHub Actions** | CI/CD automation and deployment pipeline |
| **Git / GitHub** | Source control, pull request reviews, audit trail |
| **VS Code** | Development environment |

---

## 📁 Repository Structure

```text
Terraform-Snowflake-RBAC-Automation/
├── .github/
│   └── workflows/
│       └── snowflake-terraform-cicd.yml  # CI/CD pipeline definition
├── environments/
│   ├── dev.tfvars                        # Development environment config
│   ├── staging.tfvars                    # Staging environment config
│   └── prod.tfvars                       # Production environment config
├── modules/
│   ├── users/                            # Snowflake user lifecycle management
│   ├── roles/                            # Role definitions and hierarchy
│   ├── grants/                           # Role-to-role and role-to-user assignments
│   └── object_grants/                    # Privilege grants on databases, schemas, tables, views, warehouses
├── backend.tf                            # Terraform Cloud remote state configuration
├── main.tf                               # Root module — orchestrates all sub-modules
├── providers.tf                          # Snowflake provider configuration
├── variables.tf                          # Global input variable definitions
└── README.md                             # Documentation
```

---

## 🚀 CI/CD Pipeline

Changes are deployed through a **7-stage GitHub Actions pipeline**, triggered on pushes and pull requests to `develop` and `main`.

```
┌──────────┐     ┌──────────┐     ┌───────────┐     ┌─────────────────┐     ┌────────────────┐     ┌──────────────┐     ┌─────────────┐
│ Validate │────▶│ Plan Dev │────▶│ Apply Dev │────▶│ Plan Staging    │────▶│ Apply Staging  │────▶│ Plan Prod    │────▶│ Apply Prod  │
│          │     │          │     │ (develop  │     │ (main push only)│     │ (approval gate)│     │              │     │ (manual     │
│          │     │          │     │ push only)│     │                 │     │                │     │              │     │  approval)  │
└──────────┘     └──────────┘     └───────────┘     └─────────────────┘     └────────────────┘     └──────────────┘     └─────────────┘
```

| Stage | Trigger | Description |
|---|---|---|
| **Validate** | All events | Runs `terraform fmt`, `terraform init`, and `terraform validate`. Comments results on PRs. |
| **Plan Dev** | PR or push to `develop` | Plans changes against `dev.tfvars`. Uploads plan artifact if changes detected. Comments plan on PRs. |
| **Apply Dev** | Push to `develop` + changes detected | Applies dev plan automatically after merge to `develop`. |
| **Plan Staging** | Push to `main` | Plans changes against `staging.tfvars`. |
| **Apply Staging** | Changes detected + approval | Applies staging plan after manual environment approval. |
| **Plan Prod** | After staging apply | Plans changes against `prod.tfvars`. |
| **Apply Prod** | Changes detected + manual approval | Applies production plan after required reviewer sign-off. |

### Required GitHub Secrets

| Secret | Description |
|---|---|
| `TF_API_TOKEN` | Terraform Cloud API token |
| `SNOWFLAKE_ORGANIZATION` | Snowflake organization name |
| `SNOWFLAKE_ACCOUNT_NAME` | Snowflake account name |
| `SNOWFLAKE_DEV_USER` | Terraform service account for dev |
| `SNOWFLAKE_DEV_PASSWORD` | Password for dev service account |
| `SNOWFLAKE_STAGING_USER` | Terraform service account for staging |
| `SNOWFLAKE_STAGING_PASSWORD` | Password for staging service account |
| `SNOWFLAKE_PROD_USER` | Terraform service account for prod |
| `SNOWFLAKE_PROD_PASSWORD` | Password for prod service account |

---

## 🏗️ Module Architecture

### `modules/roles`
Creates Snowflake account roles defined declaratively in the environment `.tfvars` file.

### `modules/users`
Provisions Snowflake users with configurable login names, display names, default roles, and password policies.

### `modules/grants`
Manages role-to-role hierarchy and role-to-user assignments.

### `modules/object_grants`
Handles all privilege grants on Snowflake objects. Supports:

| Grant Type | Resource |
|---|---|
| `database_grants` | Privileges on a database (e.g. `USAGE`, `CREATE SCHEMA`) |
| `schema_grants` | Privileges on a schema (e.g. `USAGE`, `CREATE TABLE`) |
| `table_grants` | Privileges on a specific table |
| `all_tables_grants` | Bulk privileges on all existing tables in a schema |
| `future_tables_grants` | Auto-privileges on tables created in the future |
| `view_grants` | Privileges on a specific view |
| `warehouse_grants` | Privileges on a warehouse (e.g. `USAGE`, `OPERATE`) |

---

## 🌍 Environments

Each environment has an isolated Terraform Cloud workspace and a dedicated `.tfvars` file defining its roles, users, grants, and Snowflake objects.

| Environment | Workspace | Branch | Apply Trigger |
|---|---|---|---|
| Dev | `snowflake-dev` | `develop` | Automatic on push |
| Staging | `snowflake-staging` | `main` | Manual approval |
| Production | `snowflake-prod` | `main` | Required reviewer approval |

---

## 🚀 Getting Started

### Prerequisites

- Terraform >= 1.0
- Terraform Cloud account with a configured organization
- Snowflake account with `SECURITYADMIN` or `ACCOUNTADMIN` privileges for the service account
- GitHub repository with Actions enabled and secrets configured

### Local Development

```bash
# Clone the repository
git clone https://github.com/007ekho/Terraform-Snowflake-RBAC-Automation.git
cd Terraform-Snowflake-RBAC-Automation

# Set credentials via environment variables
export TF_VAR_snowflake_organization="YOUR_ORG"
export TF_VAR_snowflake_account_name="YOUR_ACCOUNT"
export TF_VAR_snowflake_user="your-service-account"
export TF_VAR_snowflake_password="your-password"
export TF_VAR_snowflake_role="SECURITYADMIN"

# Authenticate with Terraform Cloud
terraform login

# Initialize (connects to Terraform Cloud backend)
terraform init

# Plan against a specific environment
terraform plan -var-file="environments/dev.tfvars"

# Apply
terraform apply -var-file="environments/dev.tfvars"
```

### CI/CD Deployment

1. Push Terraform changes (`.tf` or `environments/**`) to the `develop` branch to trigger the dev pipeline.
2. Open a pull request to `main` to trigger plan previews with PR comments.
3. Merge to `main` to promote through staging and production with approval gates.

---

## 👤 Author

**Success Ekhosuehi**  
GitHub: https://github.com/007ekho  
LinkedIn: https://www.linkedin.com/in/suehi/
