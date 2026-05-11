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