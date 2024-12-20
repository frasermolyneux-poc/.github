//resource "azurerm_resource_group" "rg_github_kv" {
//  name     = "rg-github-keyvault-${var.location}"
//  location = var.location
//
//  tags = var.tags
//}
//
//resource "azurerm_key_vault" "github_kv" {
//  name                = "kv-${random_id.environment_id.hex}-${var.location}"
//  location            = azurerm_resource_group.rg_github_kv.location
//  resource_group_name = azurerm_resource_group.rg_github_kv.name
//  tenant_id           = data.azurerm_client_config.current.tenant_id
//
//  tags = var.tags
//
//  soft_delete_retention_days = 90
//  purge_protection_enabled   = true
//  enable_rbac_authorization  = true
//
//  sku_name = "standard"
//
//  network_acls {
//    bypass         = "AzureServices"
//    default_action = "Allow"
//  }
//}
//
//resource "azurerm_role_assignment" "deploy_principal_kv_role_assignment" {
//  scope                = azurerm_key_vault.github_kv.id
//  role_definition_name = "Key Vault Secrets Officer"
//  principal_id         = data.azurerm_client_config.current.object_id
//}
