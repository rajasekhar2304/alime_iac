variable "firewalls" {
  description = "Map of Azure Firewalls"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    sku_name            = string
    sku_tier            = string
    subnet_id           = string
    public_ip_name      = string
    firewall_policy_id  = optional(string)
    tags                = optional(map(string), {})
  }))
}

variable "common_tags" {
  type = map(string)
}