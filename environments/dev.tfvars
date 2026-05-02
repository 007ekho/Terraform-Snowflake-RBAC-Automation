# environments/dev.tfvars
# Development Environment Configuration

# ============================================
# SNOWFLAKE CONNECTION (for provider)
# ============================================
# Note: These should be set via environment variables in CI/CD:
# export TF_VAR_snowflake_organization="YOUR_ORG"
# export TF_VAR_snowflake_account_name="YOUR_ACCOUNT"
# export TF_VAR_snowflake_user="terraform_user"
# export TF_VAR_snowflake_password="***"
# export TF_VAR_snowflake_role="SECURITYADMIN"

# ============================================
# ROLES
# ============================================
roles = {
  DATA_ENGINEER_DEV = {
    comment = "Development data engineering role - full database access"
  }
  DATA_ANALYST_DEV = {
    comment = "Development analytics role - read-only access"
  }
}

# ============================================
# USERS
# ============================================
users = {
  dev_engineer = {
    login_name           = "dev.engineer@company.com"
    display_name         = "Dev Engineer"
    email                = "dev.engineer@company.com"
    default_role         = "DATA_ENGINEER_DEV"
    must_change_password = false  # Dev convenience
  }
  dev_analyst = {
    login_name           = "dev.analyst@company.com"
    display_name         = "Dev Analyst"
    email                = "dev.analyst@company.com"
    default_role         = "DATA_ANALYST_DEV"
    must_change_password = false
  }
}

# ============================================
# ROLE GRANTS (role-to-role and role-to-user)
# ============================================
role_grants = {
  # Grant DATA_ANALYST_DEV to DATA_ENGINEER_DEV (hierarchy)
  engineer_inherits_analyst_dev = {
    roles = ["DATA_ANALYST_DEV"]
    users = []
  }
  
  # Grant roles to users
  grant_engineer_role_dev = {
    roles = ["DATA_ENGINEER_DEV"]
    users = ["dev.engineer@company.com"]
  }
  grant_analyst_role_dev = {
    roles = ["DATA_ANALYST_DEV"]
    users = ["dev.analyst@company.com"]
  }
}

# ============================================
# DATABASE GRANTS
# ============================================
database_grants = {
  engineer_db_usage_dev = {
    role       = "DATA_ENGINEER_DEV"
    database   = "ANALYTICS_DEV"
    privileges = ["USAGE", "CREATE SCHEMA", "MONITOR"]
  }
  analyst_db_usage_dev = {
    role       = "DATA_ANALYST_DEV"
    database   = "ANALYTICS_DEV"
    privileges = ["USAGE"]
  }
}

# ============================================
# SCHEMA GRANTS
# ============================================
schema_grants = {
  engineer_raw_schema_dev = {
    role       = "DATA_ENGINEER_DEV"
    database   = "ANALYTICS_DEV"
    schema     = "RAW"
    privileges = ["USAGE", "CREATE TABLE", "CREATE VIEW"]
  }
  engineer_staging_schema_dev = {
    role       = "DATA_ENGINEER_DEV"
    database   = "ANALYTICS_DEV"
    schema     = "STAGING"
    privileges = ["USAGE", "CREATE TABLE", "CREATE VIEW"]
  }
  analyst_analytics_schema_dev = {
    role       = "DATA_ANALYST_DEV"
    database   = "ANALYTICS_DEV"
    schema     = "ANALYTICS"
    privileges = ["USAGE"]
  }
}

# ============================================
# ALL TABLES GRANTS (existing tables)
# ============================================
all_tables_grants = {
  analyst_select_all_analytics_dev = {
    role           = "DATA_ANALYST_DEV"
    database       = "ANALYTICS_DEV"
    schema         = "ANALYTICS"
    privileges     = ["SELECT"]
    all_privileges = false
  }
  engineer_select_all_raw_dev = {
    role           = "DATA_ENGINEER_DEV"
    database       = "ANALYTICS_DEV"
    schema         = "RAW"
    privileges     = ["SELECT", "INSERT", "UPDATE", "DELETE"]
    all_privileges = false
  }
}

# ============================================
# FUTURE TABLES GRANTS (auto-grant on new tables)
# ============================================
future_tables_grants = {
  analyst_future_select_dev = {
    role       = "DATA_ANALYST_DEV"
    database   = "ANALYTICS_DEV"
    schema     = "ANALYTICS"
    privileges = ["SELECT"]
  }
  engineer_future_all_raw_dev = {
    role       = "DATA_ENGINEER_DEV"
    database   = "ANALYTICS_DEV"
    schema     = "RAW"
    privileges = ["SELECT", "INSERT", "UPDATE", "DELETE"]
  }
}

# ============================================
# WAREHOUSE GRANTS
# ============================================
warehouse_grants = {
  engineer_wh_dev = {
    role       = "DATA_ENGINEER_DEV"
    warehouse  = "DEV_WH"
    privileges = ["USAGE", "OPERATE"]
  }
  analyst_wh_dev = {
    role       = "DATA_ANALYST_DEV"
    warehouse  = "ANALYST_WH"
    privileges = ["USAGE"]
  }
}

# ============================================
# TABLE GRANTS (specific tables - optional)
# ============================================
table_grants = {
  # Example: Grant engineer access to specific sensitive table
  # engineer_customers_dev = {
  #   role       = "DATA_ENGINEER_DEV"
  #   database   = "ANALYTICS_DEV"
  #   schema     = "ANALYTICS"
  #   table      = "CUSTOMERS"
  #   privileges = ["SELECT"]
  # }
}

# ============================================
# VIEW GRANTS (specific views - optional)
# ============================================
view_grants = {
  # Example: Grant analyst access to specific view
  # analyst_customer_summary_dev = {
  #   role       = "DATA_ANALYST_DEV"
  #   database   = "ANALYTICS_DEV"
  #   schema     = "ANALYTICS"
  #   view       = "CUSTOMER_SUMMARY_VW"
  #   privileges = ["SELECT"]
  # }
}
