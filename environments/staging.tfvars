# environments/staging.tfvars
# Staging Environment Configuration (mirrors production)

# ============================================
# ROLES
# ============================================
roles = {
  DATA_ENGINEER_STAGING = {
    comment = "Staging data engineering role"
  }
  DATA_ANALYST_STAGING = {
    comment = "Staging analytics role"
  }
}

# ============================================
# USERS
# ============================================
users = {
  staging_engineer = {
    login_name           = "staging.engineer@company.com"
    display_name         = "Staging Engineer"
    email                = "staging.engineer@company.com"
    default_role         = "DATA_ENGINEER_STAGING"
    must_change_password = true  # Stricter security
  }
  staging_analyst = {
    login_name           = "staging.analyst@company.com"
    display_name         = "Staging Analyst"
    email                = "staging.analyst@company.com"
    default_role         = "DATA_ANALYST_STAGING"
    must_change_password = true
  }
}

# ============================================
# ROLE GRANTS
# ============================================
role_grants = {
  engineer_inherits_analyst_staging = {
    roles = ["DATA_ANALYST_STAGING"]
    users = []
  }
  grant_engineer_role_staging = {
    roles = ["DATA_ENGINEER_STAGING"]
    users = ["staging.engineer@company.com"]
  }
  grant_analyst_role_staging = {
    roles = ["DATA_ANALYST_STAGING"]
    users = ["staging.analyst@company.com"]
  }
}

# ============================================
# DATABASE GRANTS
# ============================================
database_grants = {
  engineer_db_usage_staging = {
    role       = "DATA_ENGINEER_STAGING"
    database   = "ANALYTICS_STAGING"
    privileges = ["USAGE", "CREATE SCHEMA", "MONITOR"]
  }
  analyst_db_usage_staging = {
    role       = "DATA_ANALYST_STAGING"
    database   = "ANALYTICS_STAGING"
    privileges = ["USAGE"]
  }
}

# ============================================
# SCHEMA GRANTS
# ============================================
schema_grants = {
  engineer_raw_schema_staging = {
    role       = "DATA_ENGINEER_STAGING"
    database   = "ANALYTICS_STAGING"
    schema     = "RAW"
    privileges = ["USAGE", "CREATE TABLE", "CREATE VIEW"]
  }
  analyst_analytics_schema_staging = {
    role       = "DATA_ANALYST_STAGING"
    database   = "ANALYTICS_STAGING"
    schema     = "ANALYTICS"
    privileges = ["USAGE"]
  }
}

# ============================================
# ALL TABLES GRANTS
# ============================================
all_tables_grants = {
  analyst_select_all_analytics_staging = {
    role           = "DATA_ANALYST_STAGING"
    database       = "ANALYTICS_STAGING"
    schema         = "ANALYTICS"
    privileges     = ["SELECT"]
    all_privileges = false
  }
}

# ============================================
# FUTURE TABLES GRANTS
# ============================================
future_tables_grants = {
  analyst_future_select_staging = {
    role       = "DATA_ANALYST_STAGING"
    database   = "ANALYTICS_STAGING"
    schema     = "ANALYTICS"
    privileges = ["SELECT"]
  }
}

# ============================================
# WAREHOUSE GRANTS
# ============================================
warehouse_grants = {
  engineer_wh_staging = {
    role       = "DATA_ENGINEER_STAGING"
    warehouse  = "STAGING_WH"
    privileges = ["USAGE", "OPERATE"]
  }
  analyst_wh_staging = {
    role       = "DATA_ANALYST_STAGING"
    warehouse  = "ANALYST_WH"
    privileges = ["USAGE"]
  }
}

table_grants = {}
view_grants  = {}
