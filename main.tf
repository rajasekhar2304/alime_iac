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