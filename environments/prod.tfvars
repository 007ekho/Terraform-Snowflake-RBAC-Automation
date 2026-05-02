# environments/prod.tfvars
# Production Environment Configuration

# ============================================
# ROLES
# ============================================
roles = {
  DATA_ENGINEER = {
    comment = "Production data engineering role - full database access"
  }
  DATA_ANALYST = {
    comment = "Production analytics role - read-only access"
  }
  DATA_ADMIN = {
    comment = "Production data administration role - elevated privileges"
  }
}

# ============================================
# USERS
# ============================================
users = {
  engineer_success = {
    login_name           = "success.ekhosuehi@company.com"
    display_name         = "Success Ekhosuehi"
    email                = "success.ekhosuehi@company.com"
    default_role         = "DATA_ENGINEER"
    must_change_password = true
  }
  analyst_jane = {
    login_name           = "jane.analyst@company.com"
    display_name         = "Jane Analyst"
    email                = "jane.analyst@company.com"
    default_role         = "DATA_ANALYST"
    must_change_password = true
  }
  admin_platform = {
    login_name           = "platform.admin@company.com"
    display_name         = "Platform Admin"
    email                = "platform.admin@company.com"
    default_role         = "DATA_ADMIN"
    must_change_password = true
  }
}

# ============================================
# ROLE GRANTS (role hierarchy)
# ============================================
role_grants = {
  # Admin inherits engineer privileges
  admin_inherits_engineer = {
    roles = ["DATA_ENGINEER"]
    users = []
  }
  # Engineer inherits analyst privileges
  engineer_inherits_analyst = {
    roles = ["DATA_ANALYST"]
    users = []
  }
  
  # Grant roles to users
  grant_engineer_role = {
    roles = ["DATA_ENGINEER"]
    users = ["success.ekhosuehi@company.com"]
  }
  grant_analyst_role = {
    roles = ["DATA_ANALYST"]
    users = ["jane.analyst@company.com"]
  }
  grant_admin_role = {
    roles = ["DATA_ADMIN"]
    users = ["platform.admin@company.com"]
  }
}

# ============================================
# DATABASE GRANTS
# ============================================
database_grants = {
  admin_db_full = {
    role       = "DATA_ADMIN"
    database   = "ANALYTICS_PROD"
    privileges = ["USAGE", "CREATE SCHEMA", "MONITOR", "MODIFY"]
  }
  engineer_db_usage = {
    role       = "DATA_ENGINEER"
    database   = "ANALYTICS_PROD"
    privileges = ["USAGE", "CREATE SCHEMA", "MONITOR"]
  }
  analyst_db_usage = {
    role       = "DATA_ANALYST"
    database   = "ANALYTICS_PROD"
    privileges = ["USAGE"]
  }
}

# ============================================
# SCHEMA GRANTS
# ============================================
schema_grants = {
  engineer_raw_schema = {
    role       = "DATA_ENGINEER"
    database   = "ANALYTICS_PROD"
    schema     = "RAW"
    privileges = ["USAGE", "CREATE TABLE", "CREATE VIEW"]
  }
  engineer_staging_schema = {
    role       = "DATA_ENGINEER"
    database   = "ANALYTICS_PROD"
    schema     = "STAGING"
    privileges = ["USAGE", "CREATE TABLE", "CREATE VIEW"]
  }
  engineer_analytics_schema = {
    role       = "DATA_ENGINEER"
    database   = "ANALYTICS_PROD"
    schema     = "ANALYTICS"
    privileges = ["USAGE", "CREATE TABLE", "CREATE VIEW"]
  }
  analyst_analytics_schema = {
    role       = "DATA_ANALYST"
    database   = "ANALYTICS_PROD"
    schema     = "ANALYTICS"
    privileges = ["USAGE"]
  }
}

# ============================================
# ALL TABLES GRANTS (existing tables)
# ============================================
all_tables_grants = {
  analyst_select_all_analytics = {
    role           = "DATA_ANALYST"
    database       = "ANALYTICS_PROD"
    schema         = "ANALYTICS"
    privileges     = ["SELECT"]
    all_privileges = false
  }
  engineer_full_raw = {
    role           = "DATA_ENGINEER"
    database       = "ANALYTICS_PROD"
    schema         = "RAW"
    privileges     = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE"]
    all_privileges = false
  }
}

# ============================================
# FUTURE TABLES GRANTS (auto-grant on new tables)
# ============================================
future_tables_grants = {
  analyst_future_select = {
    role       = "DATA_ANALYST"
    database   = "ANALYTICS_PROD"
    schema     = "ANALYTICS"
    privileges = ["SELECT"]
  }
  engineer_future_raw = {
    role       = "DATA_ENGINEER"
    database   = "ANALYTICS_PROD"
    schema     = "RAW"
    privileges = ["SELECT", "INSERT", "UPDATE", "DELETE"]
  }
  engineer_future_staging = {
    role       = "DATA_ENGINEER"
    database   = "ANALYTICS_PROD"
    schema     = "STAGING"
    privileges = ["SELECT", "INSERT", "UPDATE", "DELETE"]
  }
}

# ============================================
# WAREHOUSE GRANTS
# ============================================
warehouse_grants = {
  engineer_etl_wh = {
    role       = "DATA_ENGINEER"
    warehouse  = "ETL_WH"
    privileges = ["USAGE", "OPERATE"]
  }
  engineer_transform_wh = {
    role       = "DATA_ENGINEER"
    warehouse  = "TRANSFORM_WH"
    privileges = ["USAGE", "OPERATE"]
  }
  analyst_wh = {
    role       = "DATA_ANALYST"
    warehouse  = "ANALYST_WH"
    privileges = ["USAGE"]
  }
  admin_monitor_warehouses = {
    role       = "DATA_ADMIN"
    warehouse  = "ETL_WH"
    privileges = ["MONITOR", "MODIFY"]
  }
}

# ============================================
# SPECIFIC TABLE GRANTS (if needed)
# ============================================
table_grants = {
  # Example: Restrict engineer access to specific sensitive table
  # engineer_customers_restricted = {
  #   role       = "DATA_ENGINEER"
  #   database   = "ANALYTICS_PROD"
  #   schema     = "ANALYTICS"
  #   table      = "CUSTOMERS_SENSITIVE"
  #   privileges = ["SELECT"]  # No INSERT/UPDATE/DELETE
  # }
}

# ============================================
# SPECIFIC VIEW GRANTS (if needed)
# ============================================
view_grants = {
  # Example: Grant analyst access to specific aggregated view
  # analyst_customer_summary = {
  #   role       = "DATA_ANALYST"
  #   database   = "ANALYTICS_PROD"
  #   schema     = "ANALYTICS"
  #   view       = "CUSTOMER_SUMMARY_VW"
  #   privileges = ["SELECT"]
  # }
}
