resource "azurerm_application_gateway" "agw" {
  for_each            = var.application_gateways
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku {
    name     = each.value.sku.name
    tier     = each.value.sku.tier
    capacity = each.value.sku.capacity
  }
  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = each.value.subnet_id
  }
  frontend_port {
    name = each.value.frontend_port_name
    port = each.value.frontend_port
  }
  frontend_ip_configuration {
    name                 = each.value.frontend_ip_configuration_name
    public_ip_address_id = each.value.public_ip_id
  }
  backend_address_pool {
    name = each.value.backend_address_pool_name
    ip_addresses = [
      for backend in each.value.backend_addresses :
      backend.ip_address
    ]
  }
  backend_http_settings {
    name                                = each.value.backend_http_settings.name
    cookie_based_affinity               = each.value.backend_http_settings.cookie_based_affinity
    path                                = each.value.backend_http_settings.path
    port                                = each.value.backend_http_settings.port
    protocol                            = each.value.backend_http_settings.protocol
    request_timeout                     = each.value.backend_http_settings.request_timeout
    probe_name                          = each.value.backend_http_settings.probe_name
    pick_host_name_from_backend_address = true
  }
  probe {
    name                                      = each.value.probe.name
    protocol                                  = each.value.probe.protocol
    path                                      = each.value.probe.path
    interval                                  = each.value.probe.interval
    timeout                                   = each.value.probe.timeout
    unhealthy_threshold                       = each.value.probe.unhealthy_threshold
    pick_host_name_from_backend_http_settings = each.value.probe.pick_host_name_from_backend_http_settings
    host                                      = try(each.value.probe.host, null)
    match {
      status_code = [
        "200-399"
      ]
    }
  }
  http_listener {
    name                           = each.value.http_listener.name
    frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
    frontend_port_name             = each.value.frontend_port_name
    protocol                       = each.value.http_listener.protocol
    require_sni                    = each.value.http_listener.require_sni
    host_name = try(
      each.value.http_listener.host_name,
      null
    )
  }
  request_routing_rule {
    name                       = each.value.request_routing_rule.name
    rule_type                  = each.value.request_routing_rule.rule_type
    priority                   = each.value.request_routing_rule.priority
    http_listener_name         = each.value.http_listener.name
    backend_address_pool_name  = each.value.backend_address_pool_name
    backend_http_settings_name = each.value.backend_http_settings.name
  }
  tags = merge(
    var.common_tags,
    each.value.tags
  )
}