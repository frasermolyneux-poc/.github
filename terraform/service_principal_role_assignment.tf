resource "azurerm_role_assignment" "contributor" {
  for_each = { for each in local.project_environments : each.key => each }

  scope                = data.azurerm_subscription.subscription.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.principal[each.value.key].object_id
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
