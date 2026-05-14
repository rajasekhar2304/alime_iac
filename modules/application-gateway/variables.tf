variable "application_gateways" {
  description = "Map of Application Gateways"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    subnet_id           = string
    sku = object({
      name     = string
      tier     = string
      capacity = number
    })
    frontend_port                  = number
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    backend_address_pool_name      = string
    backend_addresses = list(object({
      ip_address = string
    }))
    backend_http_settings = object({
      name                  = string
      cookie_based_affinity = string
      path                  = string
      port                  = number
      protocol              = string
      request_timeout       = number
      probe_name            = string
    })
    probe = object({
      name                                      = string
      protocol                                  = string
      path                                      = string
      interval                                  = number
      timeout                                   = number
      unhealthy_threshold                       = number
      pick_host_name_from_backend_http_settings = bool
      host = optional(string)
    })
    http_listener = object({
      name        = string
      protocol    = string
      require_sni = bool
      host_name   = optional(string)
    })
    request_routing_rule = object({
      name      = string
      rule_type = string
      priority  = number
    })
    public_ip_id = string
    tags         = optional(map(string), {})
  }))
}

variable "common_tags" {
  type = map(string)
}