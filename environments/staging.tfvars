
environment = "staging"

# ============================================
# ROLES
# ============================================
roles = {
  data_engineer_staging = {
    name    = "DATA_ENGINEER_STAGING"
    comment = "Staging data engineering role"
  }
  data_analyst_staging = {
    name    = "DATA_ANALYST_STAGING"
    comment = "Staging analytics role"
  }
}

# ============================================
# USERS
# ============================================
users = {
  staging_engineer = {
    name                 = "staging.engineer@company.com"
    display_name         = "Staging Engineer"
    default_role         = "DATA_ENGINEER_STAGING"
    must_change_password = true
  }
  staging_analyst = {
    name                 = "staging.analyst@company.com"
    display_name         = "Staging Analyst"
    default_role         = "DATA_ANALYST_STAGING"
    must_change_password = true
  }
}

# ============================================
# ROLE HIERARCHY
# ============================================
role_grants = {
  data_engineer_staging = {
    roles = ["DATA_ANALYST_STAGING"]
  }
}

# ============================================
# DATABASE GRANTS
# ============================================
database_grants = {
  engineer_usage_staging = {
    database_name = "ANALYTICS_STAGING"
    privilege     = "USAGE"
    roles         = ["DATA_ENGINEER_STAGING"]
  }
  engineer_create_schema_staging = {
    database_name = "ANALYTICS_STAGING"
    privilege     = "CREATE SCHEMA"
    roles         = ["DATA_ENGINEER_STAGING"]
  }
  analyst_usage_staging = {
    database_name = "ANALYTICS_STAGING"
    privilege     = "USAGE"
    roles         = ["DATA_ANALYST_STAGING"]
  }
}

# ============================================
# SCHEMA GRANTS
# ============================================
schema_grants = {
  engineer_raw_usage_staging = {
    database_name = "ANALYTICS_STAGING"
    schema_name   = "RAW"
    privilege     = "USAGE"
    roles         = ["DATA_ENGINEER_STAGING"]
  }
  engineer_raw_create_table_staging = {
    database_name = "ANALYTICS_STAGING"
    schema_name   = "RAW"
    privilege     = "CREATE TABLE"
    roles         = ["DATA_ENGINEER_STAGING"]
  }
  analyst_analytics_usage_staging = {
    database_name = "ANALYTICS_STAGING"
    schema_name   = "ANALYTICS"
    privilege     = "USAGE"
    roles         = ["DATA_ANALYST_STAGING"]
  }
}

# ============================================
# ALL TABLES GRANTS
# ============================================
all_tables_grants = {
  analyst_select_analytics_staging = {
    database_name = "ANALYTICS_STAGING"
    schema_name   = "ANALYTICS"
    privilege     = "SELECT"
    roles         = ["DATA_ANALYST_STAGING"]
  }
}

# ============================================
# FUTURE TABLES GRANTS
# ============================================
future_tables_grants = {
  analyst_future_select_staging = {
    database_name = "ANALYTICS_STAGING"
    schema_name   = "ANALYTICS"
    privilege     = "SELECT"
    roles         = ["DATA_ANALYST_STAGING"]
  }
}

# ============================================
# WAREHOUSE GRANTS
# ============================================
warehouse_grants = {
  engineer_wh_usage_staging = {
    warehouse_name = "STAGING_WH"
    privilege      = "USAGE"
    roles          = ["DATA_ENGINEER_STAGING"]
  }
  analyst_wh_usage_staging = {
    warehouse_name = "ANALYST_WH"
    privilege      = "USAGE"
    roles          = ["DATA_ANALYST_STAGING"]
  }
}

table_grants = {}
view_grants  = {}

cost_center = "DATA_ENGINEERING"
project     = "RBAC_AUTOMATION_STAGING"
