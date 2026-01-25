variable "snowflake_organization" {
  description = "Snowflake organization name"
  type        = string
}

variable "snowflake_account_name" {
  description = "Snowflake account name"
  type        = string
}

variable "snowflake_user" {
  description = "Snowflake admin user"
  type        = string
}

variable "snowflake_password" {
  description = "Snowflake admin password"
  type        = string
  sensitive   = true
}

variable "snowflake_role" {
  description = "Snowflake admin role"
  type        = string
  default     = "ACCOUNTADMIN"
}

variable "users" {
  description = "Map of users to create"
  type = map(object({
    login_name   = string
    display_name = string
    email        = string
    default_role = string
    must_change_password = bool
  }))
}

variable "roles" {
  description = "Map of roles to create"
  type = map(object({
    comment = string
  }))
}

variable "role_grants" {
  description = "Role grants to users"
  type = map(object({
    roles = list(string)
    users = list(string)
  }))
}




variable "database_grants" {
  description = "Database level grants"
  type = map(object({
    role       = string
    database   = string
    privileges = list(string)
  }))
  default = {}
}

variable "schema_grants" {
  description = "Schema level grants"
  type = map(object({
    role       = string
    database   = string
    schema     = string
    privileges = list(string)
  }))
  default = {}
}

variable "table_grants" {
  description = "Specific table grants"
  type = map(object({
    role       = string
    database   = string
    schema     = string
    table      = string
    privileges = list(string)
  }))
  default = {}
}

variable "all_tables_grants" {
  description = "Grants on all existing tables in a schema"
  type = map(object({
    role           = string
    database       = string
    schema         = string
    privileges     = list(string)
    all_privileges = optional(bool, false)
  }))
  default = {}
}

variable "future_tables_grants" {
  description = "Grants on future tables in a schema"
  type = map(object({
    role       = string
    database   = string
    schema     = string
    privileges = list(string)
  }))
  default = {}
}

variable "view_grants" {
  description = "View grants"
  type = map(object({
    role       = string
    database   = string
    schema     = string
    view       = string
    privileges = list(string)
  }))
  default = {}
}

variable "warehouse_grants" {
  description = "Warehouse grants"
  type = map(object({
    role       = string
    warehouse  = string
    privileges = list(string)
  }))
  default = {}
}