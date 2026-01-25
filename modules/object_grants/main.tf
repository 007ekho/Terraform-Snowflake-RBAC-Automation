terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.100"
    }
  }
}

# Database Grants
resource "snowflake_grant_privileges_to_account_role" "database_grants" {
  for_each = var.database_grants

  account_role_name = upper(each.value.role)
  privileges        = each.value.privileges
  on_account_object {
    object_type = "DATABASE"
    object_name = upper(each.value.database)
  }
}

# Schema Grants
resource "snowflake_grant_privileges_to_account_role" "schema_grants" {
  for_each = var.schema_grants

  account_role_name = upper(each.value.role)
  privileges        = each.value.privileges
  on_schema {
    schema_name = "${upper(each.value.database)}.${upper(each.value.schema)}"
  }
}

# Table Grants (specific tables)
resource "snowflake_grant_privileges_to_account_role" "table_grants" {
  for_each = var.table_grants

  account_role_name = upper(each.value.role)
  privileges        = each.value.privileges
  on_schema_object {
    object_type = "TABLE"
    object_name = "${upper(each.value.database)}.${upper(each.value.schema)}.${upper(each.value.table)}"
  }
}

# All Tables in Schema Grants
resource "snowflake_grant_privileges_to_account_role" "all_tables_grants" {
  for_each = var.all_tables_grants

  account_role_name = upper(each.value.role)
  privileges        = each.value.privileges
  all_privileges    = try(each.value.all_privileges, false)
  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = "${upper(each.value.database)}.${upper(each.value.schema)}"
    }
  }
}

# Future Tables in Schema Grants
resource "snowflake_grant_privileges_to_account_role" "future_tables_grants" {
  for_each = var.future_tables_grants

  account_role_name = upper(each.value.role)
  privileges        = each.value.privileges
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = "${upper(each.value.database)}.${upper(each.value.schema)}"
    }
  }
}

# View Grants
resource "snowflake_grant_privileges_to_account_role" "view_grants" {
  for_each = var.view_grants

  account_role_name = upper(each.value.role)
  privileges        = each.value.privileges
  on_schema_object {
    object_type = "VIEW"
    object_name = "${upper(each.value.database)}.${upper(each.value.schema)}.${upper(each.value.view)}"
  }
}

# Warehouse Grants
resource "snowflake_grant_privileges_to_account_role" "warehouse_grants" {
  for_each = var.warehouse_grants

  account_role_name = upper(each.value.role)
  privileges        = each.value.privileges
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = upper(each.value.warehouse)
  }
}