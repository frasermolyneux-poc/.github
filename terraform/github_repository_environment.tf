resource "github_repository_environment" "environment" {
  for_each = { for each in local.project_environments : each.key => each }

  environment = each.value.environment
  repository  = github_repository.repository[each.value.project].name
}

resource "github_actions_environment_secret" "client_id" {
  for_each = { for each in local.project_environments : each.key => each }

  repository      = github_repository.repository[each.value.project].name
  environment     = github_repository_environment.environment[each.key].environment
  secret_name     = "AZURE_CLIENT_ID"
  plaintext_value = azuread_application.principal[each.key].object_id
}

resource "github_actions_environment_secret" "subscription_id" {
  for_each = { for each in local.project_environments : each.key => each }

  repository      = github_repository.repository[each.value.project].name
  environment     = github_repository_environment.environment[each.key].environment
  secret_name     = "AZURE_SUBSCRIPTION_ID"
  plaintext_value = var.subscription_id
}

resource "github_actions_environment_secret" "tenant_id" {
  for_each = { for each in local.project_environments : each.key => each }

  repository      = github_repository.repository[each.value.project].name
  environment     = github_repository_environment.environment[each.key].environment
  secret_name     = "AZURE_TENANT_ID"
  plaintext_value = "e9a0fc08-a9f9-413f-a6bd-a309dee590a5"
}

resource "github_actions_environment_secret" "tf_backend_subscription_id" {
  for_each = { for each in local.project_environments : each.key => each if each.configure_terraform_state == true }

  repository      = github_repository.repository[each.value.project].name
  environment     = github_repository_environment.environment[each.key].environment
  secret_name     = "tf_backend_subscription_id"
  plaintext_value = var.subscription_id
}

resource "github_actions_environment_secret" "tf_backend_resource_group_name" {
  for_each = { for each in local.project_environments : each.key => each if each.configure_terraform_state == true }

  repository      = github_repository.repository[each.value.project].name
  environment     = github_repository_environment.environment[each.key].environment
  secret_name     = "tf_backend_resource_group_name"
  plaintext_value = azurerm_resource_group.terraform_state[each.key].name
}

resource "github_actions_environment_secret" "tf_backend_storage_account_name" {
  for_each = { for each in local.project_environments : each.key => each if each.configure_terraform_state == true }

  repository      = github_repository.repository[each.value.project].name
  environment     = github_repository_environment.environment[each.key].environment
  secret_name     = "tf_backend_storage_account_name"
  plaintext_value = azurerm_storage_account.terraform_state[each.key].name
}

resource "github_actions_environment_secret" "tf_backend_container_name" {
  for_each = { for each in local.project_environments : each.key => each if each.configure_terraform_state == true }

  repository      = github_repository.repository[each.value.project].name
  environment     = github_repository_environment.environment[each.key].environment
  secret_name     = "tf_backend_container_name"
  plaintext_value = azurerm_storage_container.terraform_state[each.key].name
}

resource "github_actions_environment_secret" "tf_backend_key" {
  for_each = { for each in local.project_environments : each.key => each if each.configure_terraform_state == true }

  repository      = github_repository.repository[each.value.project].name
  environment     = github_repository_environment.environment[each.key].environment
  secret_name     = "tf_backend_key"
  plaintext_value = "terraform.tfstate"
}

