
# backend.tf
# Remote state configuration for multi-environment isolation

   terraform {
     backend "remote" {
       hostname     = "app.terraform.io"
       organization = "MY_ORG_SUCC"  # ← Your org name from Terraform Cloud
       
       workspaces {
         prefix = "snowflake-"
       }
     }
   }



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
