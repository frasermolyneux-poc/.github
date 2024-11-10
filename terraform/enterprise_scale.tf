//module "enterprise_scale" {
//  source           = "Azure/caf-enterprise-scale/azurerm"
//  version          = "~> 6.1.0"
//  default_location = var.location
//
//  providers = {
//    azurerm              = azurerm
//    azurerm.connectivity = azurerm
//    azurerm.management   = azurerm
//  }
//
//  root_parent_id = data.azurerm_client_config.current.tenant_id
//  root_id        = "MngEnv250956"
//  root_name      = "MngEnv250956"
//
//  deploy_connectivity_resources    = true
//  subscription_id_connectivity     = data.azurerm_client_config.current.subscription_id
//  configure_connectivity_resources = local.configure_connectivity_resources
//}
