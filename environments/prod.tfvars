
# environments/prod.tfvars
# Production Environment Configuration

environment = "prod"

# ============================================
# ROLES
# ============================================
roles = {
  data_engineer = {
    name    = "DATA_ENGINEER"
    comment = "Production data engineering role - full database access"
  }
  data_analyst = {
    name    = "DATA_ANALYST"
    comment = "Production analytics role - read-only access"
  }
  data_admin = {
    name    = "DATA_ADMIN"
    comment = "Production data administration role - elevated privileges"
  }
}

# ============================================
# USERS
# ============================================
users = {
  engineer_success = {
    name                 = "success.ekhosuehi@company.com"
    display_name         = "Success Ekhosuehi"
    default_role         = "DATA_ENGINEER"
    must_change_password = true
  }
  analyst_jane = {
    name                 = "jane.analyst@company.com"
    display_name         = "Jane Analyst"
    default_role         = "DATA_ANALYST"
    must_change_password = true
  }
  admin_platform = {
    name                 = "platform.admin@company.com"
    display_name         = "Platform Admin"
    default_role         = "DATA_ADMIN"
    must_change_password = true
  }
}

# ============================================
# ROLE HIERARCHY
# ============================================
role_grants = {
  data_admin = {
    roles = ["DATA_ENGINEER"]  # Admin inherits engineer privileges
  }
  data_engineer = {
    roles = ["DATA_ANALYST"]  # Engineer inherits analyst privileges
  }
}

# ============================================
# DATABASE GRANTS
# ============================================
database_grants = {
  admin_usage = {
    database_name = "ANALYTICS_PROD"
    privilege     = "USAGE"
    roles         = ["DATA_ADMIN"]
  }
  admin_create_schema = {
    database_name = "ANALYTICS_PROD"
    privilege     = "CREATE SCHEMA"
    roles         = ["DATA_ADMIN"]
  }
  admin_monitor = {
    database_name = "ANALYTICS_PROD"
    privilege     = "MONITOR"
    roles         = ["DATA_ADMIN"]
  }
  engineer_usage = {
    database_name = "ANALYTICS_PROD"
    privilege     = "USAGE"
    roles         = ["DATA_ENGINEER"]
  }
  engineer_create_schema = {
    database_name = "ANALYTICS_PROD"
    privilege     = "CREATE SCHEMA"
    roles         = ["DATA_ENGINEER"]
  }
  analyst_usage = {
    database_name = "ANALYTICS_PROD"
    privilege     = "USAGE"
    roles         = ["DATA_ANALYST"]
  }
}

# ============================================
# SCHEMA GRANTS
# ============================================
schema_grants = {
  engineer_raw_usage = {
    database_name = "ANALYTICS_PROD"
    schema_name   = "RAW"
    privilege     = "USAGE"
    roles         = ["DATA_ENGINEER"]
  }
  engineer_raw_create_table = {
    database_name = "ANALYTICS_PROD"
    schema_name   = "RAW"
    privilege     = "CREATE TABLE"
    roles         = ["DATA_ENGINEER"]
  }
  engineer_raw_create_view = {
    database_name = "ANALYTICS_PROD"
    schema_name   = "RAW"
    privilege     = "CREATE VIEW"
    roles         = ["DATA_ENGINEER"]
  }
  analyst_analytics_usage = {
    database_name = "ANALYTICS_PROD"
    schema_name   = "ANALYTICS"
    privilege     = "USAGE"
    roles         = ["DATA_ANALYST"]
  }
}

# ============================================
# ALL TABLES GRANTS (existing tables)
# ============================================
all_tables_grants = {
  analyst_select_analytics = {
    database_name = "ANALYTICS_PROD"
    schema_name   = "ANALYTICS"
    privilege     = "SELECT"
    roles         = ["DATA_ANALYST"]
  }
  engineer_select_raw = {
    database_name = "ANALYTICS_PROD"
    schema_name   = "RAW"
    privilege     = "SELECT"
    roles         = ["DATA_ENGINEER"]
  }
}

# ============================================
# FUTURE TABLES GRANTS (auto-grant on new tables)
# ============================================
future_tables_grants = {
  analyst_future_select = {
    database_name = "ANALYTICS_PROD"
    schema_name   = "ANALYTICS"
    privilege     = "SELECT"
    roles         = ["DATA_ANALYST"]
  }
  engineer_future_select_raw = {
    database_name = "ANALYTICS_PROD"
    schema_name   = "RAW"
    privilege     = "SELECT"
    roles         = ["DATA_ENGINEER"]
  }
  engineer_future_insert_raw = {
    database_name = "ANALYTICS_PROD"
    schema_name   = "RAW"
    privilege     = "INSERT"
    roles         = ["DATA_ENGINEER"]
  }
}

# ============================================
# WAREHOUSE GRANTS
# ============================================
warehouse_grants = {
  engineer_etl_usage = {
    warehouse_name = "ETL_WH"
    privilege      = "USAGE"
    roles          = ["DATA_ENGINEER"]
  }
  engineer_etl_operate = {
    warehouse_name = "ETL_WH"
    privilege      = "OPERATE"
    roles          = ["DATA_ENGINEER"]
  }
  analyst_wh_usage = {
    warehouse_name = "ANALYST_WH"
    privilege      = "USAGE"
    roles          = ["DATA_ANALYST"]
  }
  admin_all_warehouses = {
    warehouse_name = "ETL_WH"
    privilege      = "MONITOR"
    roles          = ["DATA_ADMIN"]
  }
}

# ============================================
# SPECIFIC TABLE GRANTS (if needed)
# ============================================
table_grants = {
  # Example: Grant on specific sensitive table
  # engineer_customers_select = {
  #   database_name = "ANALYTICS_PROD"
  #   schema_name   = "ANALYTICS"
  #   table_name    = "CUSTOMERS"
  #   privilege     = "SELECT"
  #   roles         = ["DATA_ENGINEER"]
  # }
}

# ============================================
# SPECIFIC VIEW GRANTS (if needed)
# ============================================
view_grants = {}

# ============================================
# METADATA
# ============================================
cost_center = "DATA_ENGINEERING"
project     = "RBAC_AUTOMATION_PROD"
