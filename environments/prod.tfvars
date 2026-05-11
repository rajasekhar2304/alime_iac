environment = "prod"

resource_groups = {
  rg = {
    name     = "alime-prod-rg"
    location = "Central India"
    tags = {
      owner = "devops"
    }
  }
}

vnets = {
  hub = {
    name                = "vnet-prod-hub"
    location            = "Central India"
    resource_group_name = "alime-prod-rg"
    address_space       = ["10.50.0.0/16"]
    tags = {
      purpose = "hub"
    }
  }
  spoke = {

    name                = "vnet-prod-spoke"
    location            = "Central India"
    resource_group_name = "alime-prod-rg"
    address_space       = ["10.51.0.0/16"]
    tags = {
      purpose = "spoke"
    }
  }
}

subnets = {
  # hub subnets
  firewall = {
    name                 = "AzureFirewallSubnet"
    resource_group_name  = "alime-prod-rg"
    virtual_network_name = "vnet-prod-hub"
    address_prefixes     = ["10.50.1.0/24"]
  }
  agw = {
    name                 = "agw-subnet"
    resource_group_name  = "alime-prod-rg"
    virtual_network_name = "vnet-prod-hub"
    address_prefixes     = ["10.50.2.0/24"]
  }
  # spoke subnets
  web = {
    name                 = "web-subnet"
    resource_group_name  = "alime-prod-rg"
    virtual_network_name = "vnet-prod-spoke"
    address_prefixes     = ["10.51.1.0/24"]
  }
  app = {
    name                 = "app-subnet"
    resource_group_name  = "alime-prod-rg"
    virtual_network_name = "vnet-prod-spoke"
    address_prefixes     = ["10.51.2.0/24"]
  }
  db = {
    name                 = "db-subnet"
    resource_group_name  = "alime-prod-rg"
    virtual_network_name = "vnet-prod-spoke"
    address_prefixes     = ["10.51.3.0/24"]
  }
}

nsgs = {
  agw = {
    name                = "nsg-prod-agw"
    location            = "Central India"
    resource_group_name = "alime-prod-rg"
    tags = {
      purpose = "application-gateway"
    }
  }
  web = {
    name                = "nsg-prod-web"
    location            = "Central India"
    resource_group_name = "alime-prod-rg"
    tags = {
      purpose = "web-tier"
    }
  }
  app = {
    name                = "nsg-prod-app"
    location            = "Central India"
    resource_group_name = "alime-prod-rg"
    tags = {
      purpose = "app-tier"
    }
  }
  db = {
    name                = "nsg-prod-db"
    location            = "Central India"
    resource_group_name = "alime-prod-rg"
    tags = {
      purpose = "db-tier"
    }
  }
}