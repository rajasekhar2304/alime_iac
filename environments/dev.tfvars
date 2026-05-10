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