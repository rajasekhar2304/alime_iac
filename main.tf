module "resource_groups" {
  source          = "./modules/rg"
  resource_groups = var.resource_groups
  common_tags     = local.common_tags
}

module "vnets" {
  source      = "./modules/vnet"
  vnets       = var.vnets
  common_tags = local.common_tags
  depends_on  = [module.resource_groups]
}

module "subnets" {
  source     = "./modules/subnet"
  subnets    = var.subnets
  depends_on = [module.vnets]
}

module "nsgs" {
  source      = "./modules/nsg"
  nsgs        = var.nsgs
  common_tags = local.common_tags
  depends_on  = [module.resource_groups]
}

module "nsg_associations" {
  source = "./modules/nsg-association"
  nsg_associations = {
    for k, association in var.nsg_associations :
    k => {
      subnet_id                 = module.subnets.subnet_ids[association.subnet_key]
      network_security_group_id = module.nsgs.nsg_ids[association.nsg_key]
    }
  }
}

module "nsg_rules" {
  source    = "./modules/nsg-rules"
  nsg_rules = var.nsg_rules
  depends_on = [
    module.nsgs
  ]
}

module "firewall_policies" {
  source            = "./modules/firewall-policy"
  firewall_policies = var.firewall_policies
  common_tags       = local.common_tags
  depends_on        = [module.resource_groups]
}

module "firewalls" {
  source = "./modules/firewall"
  firewalls = {
    for k, fw in var.firewalls :
    k => merge(fw, {
      subnet_id          = module.subnets.subnet_ids[fw.subnet_key]
      firewall_policy_id = module.firewall_policies.firewall_policy_ids[k]
    })
  }
  common_tags = local.common_tags
}

module "route_tables" {
  source       = "./modules/route-table"
  route_tables = var.route_tables
  common_tags  = local.common_tags
  depends_on   = [module.resource_groups]
}

module "routes" {
  source = "./modules/routes"
  routes = {
    for k, route in var.routes :
    k => {
      name                = route.name
      resource_group_name = route.resource_group_name
      route_table_name    = module.route_tables.route_table_names[route.route_table_key]
      address_prefix      = route.address_prefix
      next_hop_type       = route.next_hop_type
      next_hop_in_ip_address = (
        route.next_hop_type == "VirtualAppliance"
        ? module.firewalls.firewall_private_ips[route.firewall_key]
        : null
      )
    }
  }
}

module "route_table_associations" {
  source = "./modules/route-table-association"
  route_table_associations = {
    for k, association in var.route_table_associations :
    k => {
      subnet_id      = module.subnets.subnet_ids[association.subnet_key]
      route_table_id = module.route_tables.route_table_ids[association.route_table_key]
    }
  }
}

module "vnet_peerings" {
  source = "./modules/vnet-peering"
  peerings = {
    for k, peering in var.peerings :
    k => {
      name                         = peering.name
      resource_group_name          = peering.resource_group_name
      virtual_network_name         = module.vnets.vnet_names[peering.vnet_key]
      remote_virtual_network_id    = module.vnets.vnet_ids[peering.remote_vnet_key]
      allow_virtual_network_access = peering.allow_virtual_network_access
      allow_forwarded_traffic      = peering.allow_forwarded_traffic
      allow_gateway_transit        = peering.allow_gateway_transit
      use_remote_gateways          = peering.use_remote_gateways
    }
  }
}

module "firewall_rule_collection_groups" {
  source = "./modules/firewall-rule-collection-group"
  firewall_rule_collection_groups = {
    for k, rcg in var.firewall_rule_collection_groups :
    k => merge(rcg, {
      firewall_policy_id = module.firewall_policies.firewall_policy_ids[rcg.firewall_policy_key]
    })
  }
}

module "nics" {
  source = "./modules/nic"
  nics = {
    for k, nic in var.nics :
    k => merge(nic, {
      subnet_id = module.subnets.subnet_ids[nic.subnet_key]
    })
  }
  common_tags = local.common_tags
  depends_on  = [module.resource_groups]
}

module "windows_vms" {
  source = "./modules/windows-vm"
  windows_vms = {
    for k, vm in var.windows_vms :
    k => merge(vm, {
      network_interface_ids = [
        module.nics.nic_ids[vm.nic_key]
      ]
      admin_username = data.azurerm_key_vault_secret.vm_admin_username.value
      admin_password = data.azurerm_key_vault_secret.vm_admin_password.value
    })
  }
  common_tags = local.common_tags
}

module "public_ips" {
  source      = "./modules/public-ip"
  public_ips  = var.public_ips
  common_tags = local.common_tags
  depends_on = [
    module.resource_groups
  ]
}

module "application_gateways" {
  source = "./modules/application-gateway"
  application_gateways = {
    for k, agw in var.application_gateways :
    k => merge(agw, {
      subnet_id    = module.subnets.subnet_ids[agw.subnet_key]
      public_ip_id = module.public_ips.public_ip_ids[agw.public_ip_key]
    })
  }
  common_tags = local.common_tags
  depends_on = [
    module.vnet_peerings,
    module.firewalls
  ]
}

module "vm_extensions" {
  source = "./modules/vm-extension"
  vm_extensions = {
    for k, ext in var.vm_extensions :
    k => merge(ext, {
      virtual_machine_id = module.windows_vms.vm_ids[ext.vm_key]
    })
  }
  depends_on = [
    module.windows_vms
  ]
}