resource "azurerm_role_assignment" "contributor" {
  for_each = { for each in local.project_environments : each.key => each }

  scope                = data.azurerm_subscription.subscription.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.principal[each.value.key].object_id
}

resource "azurerm_role_assignment" "kv_admin" {
  for_each = { for each in local.project_environments : each.key => each }

  scope                = data.azurerm_subscription.subscription.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azuread_service_principal.principal[each.value.key].object_id
}

resource "azurerm_role_assignment" "rbac_admin" {
  for_each = { for each in local.project_environments : each.key => each }

  role_definition_name = "Role Based Access Control Administrator"
  scope                = data.azurerm_subscription.subscription.id
  principal_id         = azuread_service_principal.principal[each.value.key].object_id
  description          = "Role Based Access Control Administrator role assignment with ABAC Condition."
  condition_version    = "2.0"
  condition            = <<-EOT
(
 (
  !(ActionMatches{'Microsoft.Authorization/roleAssignments/write'})
 )
 OR
 (
  @Request[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAnyValues:GuidEquals {${basename(data.azurerm_role_definition.builtin.role_definition_id)}}
 )
)
AND
(
 (
  !(ActionMatches{'Microsoft.Authorization/roleAssignments/delete'})
 )
 OR
 (
  @Resource[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAnyValues:GuidEquals {${basename(data.azurerm_role_definition.builtin.role_definition_id)}}
 )
)
EOT
}

resource "azurerm_role_assignment" "terraform_state_account_key_operator" {
  for_each = { for each in local.project_environments : each.key => each if each.configure_terraform_state == true }

  scope                = azurerm_storage_account.terraform_state[each.value.key].id
  role_definition_name = "Storage Account Key Operator Service Role"
  principal_id         = azuread_service_principal.principal[each.value.key].object_id
}

resource "azurerm_role_assignment" "terraform_state_blob_data_contributor" {
  for_each = { for each in local.project_environments : each.key => each if each.configure_terraform_state == true }

  scope                = azurerm_storage_account.terraform_state[each.value.key].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.principal[each.value.key].object_id
}
