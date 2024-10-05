resource "azuread_application" "principal" {
  for_each = { for each in local.project_environments : each.key => each }

  display_name = format("spn-%s-%s", lower(each.value.project), lower(each.value.environment))

  owners = [
    data.azuread_client_config.current.object_id
  ]

  sign_in_audience = "AzureADMyOrg"
}

resource "azuread_service_principal" "principal" {
  for_each = { for each in local.project_environments : each.key => each }

  client_id                    = azuread_application.principal[each.key].client_id
  app_role_assignment_required = false

  owners = [
    data.azuread_client_config.current.object_id
  ]
}
