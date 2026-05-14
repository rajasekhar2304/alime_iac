variable "firewall_policies" {
  description = "Map of Firewall Policies"
  type = map(object({
    name                     = string
    location                 = string
    resource_group_name      = string
    sku                      = string
    threat_intelligence_mode = optional(string, "Alert")
    tags                     = optional(map(string), {})
  }))
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}