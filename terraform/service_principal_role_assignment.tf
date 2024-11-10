//resource "azurerm_role_assignment" "contributor" {
//  for_each = { for each in local.project_environments : each.key => each }
//
//  scope                = data.azurerm_subscription.subscription.id
//  role_definition_name = "Contributor"
//  principal_id         = azuread_service_principal.principal[each.value.key].object_id
//}
//
//resource "azurerm_role_assignment" "kv_admin" {
//  for_each = { for each in local.project_environments : each.key => each }
//
//  scope                = data.azurerm_subscription.subscription.id
//  role_definition_name = "Key Vault Administrator"
//  principal_id         = azuread_service_principal.principal[each.value.key].object_id
//}
//
//resource "azurerm_role_assignment" "rbac_admin" {
//  for_each = { for each in local.project_environments : each.key => each }
//
//  role_definition_name = "Role Based Access Control Administrator"
//  scope                = data.azurerm_subscription.subscription.id
//  principal_id         = azuread_service_principal.principal[each.value.key].object_id
//  description          = "Role Based Access Control Administrator role assignment with ABAC Condition."
//  condition_version    = "2.0"
//  condition            = <<-EOT
//(
// (
//  !(ActionMatches{'Microsoft.Authorization/roleAssignments/write'})
// )
// OR 
// (
//  @Request[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAllValues:GuidNotEquals {8e3af657-a8ff-443c-a75c-2fe8c4bcb635, b24988ac-6180-42a0-ab88-20f7382dd24c, 76cc9ee4-d5d3-4a45-a930-26add3d73475, f58310d9-a9f6-439a-9e8d-f62e7b41a168, 18d7d88d-d35e-4fb5-a5c3-7773c20a72d9}
// )
//)
//AND
//(
// (
//  !(ActionMatches{'Microsoft.Authorization/roleAssignments/delete'})
// )
// OR 
// (
//  @Resource[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAllValues:GuidNotEquals {8e3af657-a8ff-443c-a75c-2fe8c4bcb635, b24988ac-6180-42a0-ab88-20f7382dd24c, 76cc9ee4-d5d3-4a45-a930-26add3d73475, f58310d9-a9f6-439a-9e8d-f62e7b41a168, 18d7d88d-d35e-4fb5-a5c3-7773c20a72d9}
// )
//)
//EOT
//}
//
//resource "azurerm_role_assignment" "terraform_state_account_key_operator" {
//  for_each = { for each in local.project_environments : each.key => each if each.configure_terraform_state == true }
//
//  scope                = azurerm_storage_account.terraform_state[each.value.key].id
//  role_definition_name = "Storage Account Key Operator Service Role"
//  principal_id         = azuread_service_principal.principal[each.value.key].object_id
//}
//
//resource "azurerm_role_assignment" "terraform_state_blob_data_contributor" {
//  for_each = { for each in local.project_environments : each.key => each if each.configure_terraform_state == true }
//
//  scope                = azurerm_storage_account.terraform_state[each.value.key].id
//  role_definition_name = "Storage Blob Data Contributor"
//  principal_id         = azuread_service_principal.principal[each.value.key].object_id
//}
