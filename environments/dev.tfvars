environment = "dev"

resource_groups = {
  rg = {
    name     = "alime-dev-rg"
    location = "Central India"
    tags = {
      owner = "devops"
    }
  }
}

vnets = {
  hub = {
    name                = "vnet-dev-hub"
    location            = "Central India"
    resource_group_name = "alime-dev-rg"
    address_space       = ["10.48.0.0/16"]
    tags = {
      purpose = "hub"
    }
  }
  spoke = {

    name                = "vnet-dev-spoke"
    location            = "Central India"
    resource_group_name = "alime-dev-rg"
    address_space       = ["10.49.0.0/16"]
    tags = {
      purpose = "spoke"
    }
  }
}

subnets = {
  # hub subnets
  firewall = {
    name                 = "AzureFirewallSubnet"
    resource_group_name  = "alime-dev-rg"
    virtual_network_name = "vnet-dev-hub"
    address_prefixes     = ["10.48.1.0/24"]
  }
  agw = {
    name                 = "agw-subnet"
    resource_group_name  = "alime-dev-rg"
    virtual_network_name = "vnet-dev-hub"
    address_prefixes     = ["10.48.2.0/24"]
  }
  # spoke subnets
  web = {
    name                 = "web-subnet"
    resource_group_name  = "alime-dev-rg"
    virtual_network_name = "vnet-dev-spoke"
    address_prefixes     = ["10.49.1.0/24"]
  }
  app = {
    name                 = "app-subnet"
    resource_group_name  = "alime-dev-rg"
    virtual_network_name = "vnet-dev-spoke"
    address_prefixes     = ["10.49.2.0/24"]
  }
  db = {
    name                 = "db-subnet"
    resource_group_name  = "alime-dev-rg"
    virtual_network_name = "vnet-dev-spoke"
    address_prefixes     = ["10.49.3.0/24"]
  }
}

nsgs = {
  agw = {
    name                = "nsg-dev-agw"
    location            = "Central India"
    resource_group_name = "alime-dev-rg"
    tags = {
      purpose = "application-gateway"
    }
  }
  web = {
    name                = "nsg-dev-web"
    location            = "Central India"
    resource_group_name = "alime-dev-rg"
    tags = {
      purpose = "web-tier"
    }
  }
  app = {
    name                = "nsg-dev-app"
    location            = "Central India"
    resource_group_name = "alime-dev-rg"
    tags = {
      purpose = "app-tier"
    }
  }
  db = {
    name                = "nsg-dev-db"
    location            = "Central India"
    resource_group_name = "alime-dev-rg"
    tags = {
      purpose = "db-tier"
    }
  }
}

nsg_associations = {
  agw = {
    subnet_key = "agw"
    nsg_key    = "agw"
  }
  web = {
    subnet_key = "web"
    nsg_key    = "web"
  }
  app = {
    subnet_key = "app"
    nsg_key    = "app"
  }
  db = {
    subnet_key = "db"
    nsg_key    = "db"
  }
}

nsg_rules = {
  agw-gateway-manager = {
    name                        = "allow-gateway-manager"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "65200-65535"
    source_address_prefix       = "GatewayManager"
    destination_address_prefix  = "*"
    resource_group_name         = "alime-dev-rg"
    network_security_group_name = "nsg-dev-agw"
  }
  agw-azure-lb = {
    name                        = "allow-azure-lb"
    priority                    = 110
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "AzureLoadBalancer"
    destination_address_prefix  = "*"
    resource_group_name         = "alime-dev-rg"
    network_security_group_name = "nsg-dev-agw"
  }
  agw-http = {
    name                        = "allow-http"
    priority                    = 120
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "Internet"
    destination_address_prefix  = "*"
    resource_group_name         = "alime-dev-rg"
    network_security_group_name = "nsg-dev-agw"
  }
  agw-https = {
    name                        = "allow-https"
    priority                    = 130
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "443"
    source_address_prefix       = "Internet"
    destination_address_prefix  = "*"
    resource_group_name         = "alime-dev-rg"
    network_security_group_name = "nsg-dev-agw"
  }
  web-http-from-agw = {
    name                        = "allow-http-from-agw"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "10.48.2.0/24"
    destination_address_prefix  = "*"
    resource_group_name         = "alime-dev-rg"
    network_security_group_name = "nsg-dev-web"
  }
}

firewalls = {
  hub = {
    name                = "fw-dev-hub"
    location            = "Central India"
    resource_group_name = "alime-dev-rg"
    sku_name            = "AZFW_VNet"
    sku_tier            = "Standard"
    subnet_key          = "firewall"
    public_ip_name      = "pip-dev-firewall"
    tags = {
      purpose = "hub-firewall"
    }
  }
}

route_tables = {
  agw = {
    name                = "rt-dev-agw"
    location            = "Central India"
    resource_group_name = "alime-dev-rg"
    tags = {
      purpose = "agw-routing"
    }
  }
  spoke = {
    name                = "rt-dev-spoke"
    location            = "Central India"
    resource_group_name = "alime-dev-rg"
    tags = {
      purpose = "spoke-routing"
    }
  }
}

routes = {
  agw-to-spoke = {
    name                = "agw-to-spoke"
    resource_group_name = "alime-dev-rg"
    route_table_key     = "agw"
    address_prefix      = "10.49.0.0/16"
    next_hop_type       = "VirtualAppliance"
    firewall_key        = "hub"
  }
  spoke-default = {
    name                = "spoke-default"
    resource_group_name = "alime-dev-rg"
    route_table_key     = "spoke"
    address_prefix      = "0.0.0.0/0"
    next_hop_type       = "VirtualAppliance"
    firewall_key        = "hub"
  }
  agw-return = {
    name                = "agw-return"
    resource_group_name = "alime-dev-rg"
    route_table_key     = "spoke"
    address_prefix      = "10.48.2.0/24"
    next_hop_type       = "VnetLocal"
  }
}

route_table_associations = {
  app = {
    subnet_key      = "app"
    route_table_key = "spoke"
  }

  db = {
    subnet_key      = "db"
    route_table_key = "spoke"
  }
}

peerings = {
  hub-to-spoke = {
    name                         = "peer-hub-to-spoke"
    resource_group_name          = "alime-dev-rg"
    vnet_key                     = "hub"
    remote_vnet_key              = "spoke"
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
  }
  spoke-to-hub = {
    name                         = "peer-spoke-to-hub"
    resource_group_name          = "alime-dev-rg"
    vnet_key                     = "spoke"
    remote_vnet_key              = "hub"
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
  }
}

firewall_policies = {
  hub = {
    name                     = "fwpolicy-dev-hub"
    location                 = "Central India"
    resource_group_name      = "alime-dev-rg"
    sku                      = "Standard"
    threat_intelligence_mode = "Alert"
    tags = {
      purpose = "hub-firewall-policy"
    }
  }
}

firewall_rule_collection_groups = {
  hub = {
    name                = "fwrcg-dev-hub"
    firewall_policy_key = "hub"
    priority            = 100

    network_rule_collections = [
      {
        name     = "network-rules"
        priority = 100
        action   = "Allow"

        rules = [
          {
            name                  = "allow-web-outbound"
            protocols             = ["TCP"]
            source_addresses      = ["10.49.1.0/24"]
            destination_addresses = ["*"]
            destination_ports     = ["80", "443"]
          },
          {
            name                  = "allow-app-to-db"
            protocols             = ["TCP"]
            source_addresses      = ["10.49.2.0/24"]
            destination_addresses = ["10.49.3.0/24"]
            destination_ports     = ["1433"]
          }
        ]
      }
    ]

    application_rule_collections = [
      {
        name     = "application-rules"
        priority = 200
        action   = "Allow"

        rules = [
          {
            name             = "allow-windows-update"
            source_addresses = ["10.49.1.0/24"]

            destination_fqdns = [
              "*.windowsupdate.com"
            ]

            protocols = [
              {
                type = "Http"
                port = 80
              },
              {
                type = "Https"
                port = 443
              }
            ]
          }
        ]
      }
    ]

    nat_rule_collections = [
      {
        name     = "rdp-nat"
        priority = 300
        action   = "Dnat"

        rules = [
          {
            name                = "rdp-web-vm"
            protocols           = ["TCP"]
            source_addresses    = ["*"]
            destination_address = ""
            destination_ports   = ["3389"]
            translated_address  = "10.49.1.10"
            translated_port     = "3389"
          }
        ]
      }
    ]
  }
}

nics = {
  web = {
    name                          = "nic-dev-web"
    location                      = "Central India"
    resource_group_name           = "alime-dev-rg"
    subnet_key                    = "web"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.49.1.10"
    tags = {
      purpose = "web-tier"
    }
  }

  app = {
    name                          = "nic-dev-app"
    location                      = "Central India"
    resource_group_name           = "alime-dev-rg"
    subnet_key                    = "app"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.49.2.10"
    tags = {
      purpose = "app-tier"
    }
  }

  db = {
    name                          = "nic-dev-db"
    location                      = "Central India"
    resource_group_name           = "alime-dev-rg"
    subnet_key                    = "db"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.49.3.10"
    tags = {
      purpose = "db-tier"
    }
  }
}

windows_vms = {
  web = {
    name                = "vm-dev-web"
    location            = "Central India"
    resource_group_name = "alime-dev-rg"
    size                = "Standard_B2als_v2"
    nic_key             = "web"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2022-datacenter-azure-edition"
      version   = "latest"
    }
    tags = {
      role = "web"
    }
  }
}

public_ips = {
  agw = {
    name                = "pip-dev-agw"
    location            = "Central India"
    resource_group_name = "alime-dev-rg"
    allocation_method   = "Static"
    sku                 = "Standard"
    domain_name_label   = "alime-dev-agw"
    tags = {
      purpose = "application-gateway"
    }
  }
}

application_gateways = {
  agw = {
    name                = "agw-dev"
    location            = "Central India"
    resource_group_name = "alime-dev-rg"
    subnet_key          = "agw"
    public_ip_key       = "agw"
    sku = {
      name     = "Standard_v2"
      tier     = "Standard_v2"
      capacity = 2
    }
    frontend_port                  = 80
    frontend_ip_configuration_name = "frontend-ip-config"
    frontend_port_name             = "frontend-port"
    backend_address_pool_name      = "backend-pool"
    backend_addresses = [
      {
        ip_address = "10.49.1.10"
      }
    ]
    backend_http_settings = {
      name                  = "backend-http-settings"
      cookie_based_affinity = "Disabled"
      path                  = "/"
      port                  = 80
      protocol              = "Http"
      request_timeout       = 30
      probe_name            = "health-probe"
    }
    probe = {
      name                                      = "health-probe"
      protocol                                  = "Http"
      path                                      = "/"
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      pick_host_name_from_backend_http_settings = false
      host                                      = "127.0.0.1"
    }
    http_listener = {
      name        = "http-listener"
      protocol    = "Http"
      require_sni = false
    }
    request_routing_rule = {
      name      = "routing-rule"
      rule_type = "Basic"
      priority  = 100
    }
    tags = {
      purpose = "application-gateway"
    }
  }
}

vm_extensions = {
  web-iis = {
    name                       = "install-iis"
    vm_key                     = "web"
    publisher                  = "Microsoft.Compute"
    type                       = "CustomScriptExtension"
    type_handler_version       = "1.10"
    auto_upgrade_minor_version = true
    settings                   = <<SETTINGS
{
  "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -Command \"Install-WindowsFeature -Name Web-Server -IncludeManagementTools; Set-Content -Path 'C:\\\\inetpub\\\\wwwroot\\\\index.html' -Value '<h1>Welcome to Alime Web Server</h1>'\""
}
SETTINGS
  }
}