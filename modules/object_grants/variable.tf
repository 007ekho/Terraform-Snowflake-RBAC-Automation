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