
# backend.tf
# Remote state configuration for multi-environment isolation

#terraform {
#  backend "remote" {
#    hostname     = "app.terraform.io"
#   organization = "your-org-name"  # Replace with your Terraform Cloud org
#    
#    workspaces {
#      # Uses workspace prefix: snowflake-dev, snowflake-staging, snowflake-prod
#      prefix = "snowflake-"
#    }
#  }
#}

# Alternative: S3 backend (if not using Terraform Cloud)
# terraform {
#   backend "s3" {
#     bucket         = "your-company-terraform-state"
#     key            = "snowflake/${var.environment}/terraform.tfstate"
#     region         = "eu-west-2"
#     encrypt        = true
#     dynamodb_table = "terraform-state-lock"
#   }
# }
