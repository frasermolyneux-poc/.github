locals {
  hub_networks_by_location = {
    for i, v in module.enterprise_scale.azurerm_virtual_network.connectivity :
    v.location => v
  }
}

module "lz_vending" {
  for_each = { for each in local.project_environments : each.key => each if each.vnet_spoke != null }

  source  = "Azure/lz-vending/azurerm"
  version = "~> 4.1.4"

  location = var.location

  # subscription variables
  subscription_id = var.subscription_id

  network_watcher_resource_group_enabled = false

  # management group association variables
  subscription_management_group_association_enabled = false

  # virtual network variables
  virtual_network_enabled = true
  virtual_networks = {
    spoke_vnet_1 = {
      name                    = format("vnet-%s-%s-%s", each.value.project, each.value.environment, var.location)
      address_space           = [each.value.vnet_spoke.address_space]
      resource_group_name     = format("rg-%s-connectivity-%s-%s", each.value.project, each.value.environment, var.location)
      hub_peering_enabled     = true
      hub_network_resource_id = local.hub_networks_by_location[var.location].id
    }
  }
}
