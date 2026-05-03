# main.tf
# Orchestrates all Snowflake RBAC modules




module "roles" {
  source = "./modules/roles"
  roles  = var.roles
}

module "users" {
  source = "./modules/users"
  users  = var.users
  
  depends_on = [module.roles]
}

module "grants" {
  source      = "./modules/grants"
  role_grants = var.role_grants
  
  depends_on = [module.users, module.roles]
}

module "object_grants" {
  source = "./modules/object_grants"
  
  database_grants      = var.database_grants
  schema_grants        = var.schema_grants
  table_grants         = var.table_grants
  all_tables_grants    = var.all_tables_grants
  future_tables_grants = var.future_tables_grants
  view_grants          = var.view_grants
  warehouse_grants     = var.warehouse_grants
  
  depends_on = [module.roles]
}



# Optional: Add warehouse module if you want to manage compute
# module "warehouse" {
#   source = "./modules/warehouse"
#   
#   warehouse_name = "${var.environment}_WH"
#   warehouse_size = var.warehouse_size
# }
# Test v5
# Test v6 - fixed duplicate provider
