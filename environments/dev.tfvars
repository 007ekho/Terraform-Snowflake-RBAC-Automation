
environment = "dev"

# ============================================
# ROLES
# ============================================
roles = {
  data_engineer_dev = {
    name    = "DATA_ENGINEER_DEV"
    comment = "Development data engineering role - full database access"
  }
  data_analyst_dev = {
    name    = "DATA_ANALYST_DEV"
    comment = "Development analytics role - read-only access"
  }
}

# ============================================
# USERS
# ============================================
users = {
  dev_engineer = {
    name                 = "dev.engineer@company.com"
    display_name         = "Dev Engineer"
    default_role         = "DATA_ENGINEER_DEV"
    must_change_password = false  # Dev convenience
  }
  dev_analyst = {
    name                 = "dev.analyst@company.com"
    display_name         = "Dev Analyst"
    default_role         = "DATA_ANALYST_DEV"
    must_change_password = false
  }
}

# ============================================
# ROLE HIERARCHY (role-to-role grants)
# ============================================
role_grants = {
  data_engineer_dev = {
    roles = ["DATA_ANALYST_DEV"]  # Engineer inherits from Analyst
  }
}

# ============================================
# DATABASE GRANTS
# ============================================
database_grants = {
  engineer_usage_dev = {
    database_name = "ANALYTICS_DEV"
    privilege     = "USAGE"
    roles         = ["DATA_ENGINEER_DEV"]
  }
  engineer_create_schema_dev = {
    database_name = "ANALYTICS_DEV"
    privilege     = "CREATE SCHEMA"
    roles         = ["DATA_ENGINEER_DEV"]
  }
  analyst_usage_dev = {
    database_name = "ANALYTICS_DEV"
    privilege     = "USAGE"
    roles         = ["DATA_ANALYST_DEV"]
  }
}

# ============================================
# SCHEMA GRANTS
# ============================================
schema_grants = {
  engineer_raw_usage_dev = {
    database_name = "ANALYTICS_DEV"
    schema_name   = "RAW"
    privilege     = "USAGE"
    roles         = ["DATA_ENGINEER_DEV"]
  }
  engineer_raw_create_table_dev = {
    database_name = "ANALYTICS_DEV"
    schema_name   = "RAW"
    privilege     = "CREATE TABLE"
    roles         = ["DATA_ENGINEER_DEV"]
  }
  analyst_analytics_usage_dev = {
    database_name = "ANALYTICS_DEV"
    schema_name   = "ANALYTICS"
    privilege     = "USAGE"
    roles         = ["DATA_ANALYST_DEV"]
  }
}

# ============================================
# ALL TABLES GRANTS (existing tables)
# ============================================
all_tables_grants = {
  analyst_select_analytics_dev = {
    database_name = "ANALYTICS_DEV"
    schema_name   = "ANALYTICS"
    privilege     = "SELECT"
    roles         = ["DATA_ANALYST_DEV"]
  }
  engineer_select_raw_dev = {
    database_name = "ANALYTICS_DEV"
    schema_name   = "RAW"
    privilege     = "SELECT"
    roles         = ["DATA_ENGINEER_DEV"]
  }
}

# ============================================
# FUTURE TABLES GRANTS (auto-grant on new tables)
# ============================================
future_tables_grants = {
  analyst_future_select_dev = {
    database_name = "ANALYTICS_DEV"
    schema_name   = "ANALYTICS"
    privilege     = "SELECT"
    roles         = ["DATA_ANALYST_DEV"]
  }
  engineer_future_select_dev = {
    database_name = "ANALYTICS_DEV"
    schema_name   = "RAW"
    privilege     = "SELECT"
    roles         = ["DATA_ENGINEER_DEV"]
  }
}

# ============================================
# WAREHOUSE GRANTS
# ============================================
warehouse_grants = {
  engineer_wh_usage_dev = {
    warehouse_name = "DEV_WH"
    privilege      = "USAGE"
    roles          = ["DATA_ENGINEER_DEV"]
  }
  engineer_wh_operate_dev = {
    warehouse_name = "DEV_WH"
    privilege      = "OPERATE"
    roles          = ["DATA_ENGINEER_DEV"]
  }
  analyst_wh_usage_dev = {
    warehouse_name = "ANALYST_WH"
    privilege      = "USAGE"
    roles          = ["DATA_ANALYST_DEV"]
  }
}

# ============================================
# TABLE GRANTS (specific tables - optional)
# ============================================
table_grants = {}

# ============================================
# VIEW GRANTS (specific views - optional)
# ============================================
view_grants = {}

# ============================================
# METADATA
# ============================================
cost_center = "DATA_ENGINEERING"
project     = "RBAC_AUTOMATION_DEV"
