resource "azuread_application" "this" {
  display_name = format("spn-%s-%s", var.workload, var.environment)

  owners = [
    data.azuread_client_config.current.object_id
  ]

  sign_in_audience = "AzureADMyOrg"
}

resource "azuread_service_principal" "this" {
  client_id = azuread_application.this.client_id

  app_role_assignment_required = false

  owners = [
    data.azuread_client_config.current.object_id
  ]
}
