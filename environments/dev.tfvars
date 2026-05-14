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
}

route_table_associations = {
  agw = {
    subnet_key      = "agw"
    route_table_key = "agw"
  }
  web = {
    subnet_key      = "web"
    route_table_key = "spoke"
  }
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