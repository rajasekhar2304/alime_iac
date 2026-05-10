module "resource_groups" {
  source          = "./modules/rg"
  resource_groups = var.resource_groups
  common_tags     = local.common_tags
}