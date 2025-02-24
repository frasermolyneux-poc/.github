resource "azuread_application_federated_identity_credential" "oidc" {
  for_each = { for each in local.project_environments : each.key => each }

  application_id = azuread_application.principal[each.key].id
  display_name   = format("github-%s-%s", lower(each.value.project), lower(each.value.environment))
  description    = "GitHub Actions"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = format("repo:frasermolyneux-poc/%s:environment:%s", lower(each.value.project), each.value.environment)
}
