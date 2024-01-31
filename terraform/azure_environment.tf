module "azure_environment_mngenv102652" {
  for_each = { for each in local.project_environments : each.key => each if each.azure_tenant != null && each.azure_tenant == "mngenv102652" }

  source      = "./modules/azure_environment"
  workload    = each.value.project
  environment = each.value.environment

  providers = {
    azurerm = azurerm.mngenv102652
  }
}

module "azure_environment_molyneuxio" {
  for_each = { for each in local.project_environments : each.key => each if each.azure_tenant != null && each.azure_tenant == "molyneuxio" }

  source      = "./modules/azure_environment"
  workload    = each.value.project
  environment = each.value.environment

  providers = {
    azurerm = azurerm.molyneuxio
  }
}
