//resource "azurerm_resource_group" "terraform_state" {
//  for_each = { for each in local.project_environments : each.key => each if each.configure_terraform_state == true }
//
//  name     = format("rg-tf-%s-%s-%s", each.value.project, each.value.environment, var.location)
//  location = var.location
//
//  tags = merge(var.tags, { Workload = each.value.project, Environment = each.value.environment })
//}
//
//resource "azurerm_storage_account" "terraform_state" {
//  for_each = { for each in local.project_environments : each.key => each if each.configure_terraform_state == true }
//
//  name                = format("sa%s", random_id.environment[each.value.key].hex)
//  resource_group_name = azurerm_resource_group.terraform_state[each.value.key].name
//  location            = azurerm_resource_group.terraform_state[each.value.key].location
//
//  account_tier             = "Standard"
//  account_replication_type = "LRS"
//
//  min_tls_version                 = "TLS1_2"
//  allow_nested_items_to_be_public = false
//
//  local_user_enabled        = false
//  shared_access_key_enabled = false
//
//  tags = merge(var.tags, { Workload = each.value.project, Environment = each.value.environment })
//}
//
//resource "azurerm_storage_container" "terraform_state" {
//  for_each = { for each in local.project_environments : each.key => each if each.configure_terraform_state == true }
//
//  name                  = "tfstate"
//  storage_account_name  = azurerm_storage_account.terraform_state[each.value.key].name
//  container_access_type = "private"
//}
