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
  source = "./modules/nsg"
  nsgs        = var.nsgs
  common_tags = local.common_tags
  depends_on = [module.subnets]
}

module "nsg_associations" {
  source = "./modules/nsg-association"
  nsg_associations = {
    for k, association in var.nsg_associations :
    k => {
      subnet_id = module.subnets.subnet_ids[association.subnet_key]
      network_security_group_id = module.nsgs.nsg_ids[association.nsg_key]
    }
  }
  depends_on = [
    module.subnets,
    module.nsgs
  ]
}

module "nsg_rules" {
  source = "./modules/nsg-rules"
  nsg_rules = var.nsg_rules
  depends_on = [
    module.nsgs,
    module.nsg_associations
  ]
}