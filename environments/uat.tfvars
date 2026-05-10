environment = "uat"
resource_groups = {
  rg = {
    name     = "alime-uat-rg"
    location = "Central India"
    tags = {
      owner = "devops"
    }
  }
}
vnets = {
  hub = {
    name                = "vnet-uat-hub"
    location            = "Central India"
    resource_group_name = "alime-uat-rg"
    address_space       = ["10.52.0.0/16"]
    tags = {
      purpose = "hub"
    }
  }
  spoke = {

    name                = "vnet-uat-spoke"
    location            = "Central India"
    resource_group_name = "alime-uat-rg"
    address_space       = ["10.53.0.0/16"]
    tags = {
      purpose = "spoke"
    }
  }
}

subnets = {
  # hub subnets
  firewall = {
    name                 = "AzureFirewallSubnet"
    resource_group_name  = "alime-uat-rg"
    virtual_network_name = "vnet-uat-hub"
    address_prefixes     = ["10.52.1.0/24"]
  }
  agw = {
    name                 = "agw-subnet"
    resource_group_name  = "alime-uat-rg"
    virtual_network_name = "vnet-uat-hub"
    address_prefixes     = ["10.52.2.0/24"]
  }
  # spoke subnets
  web = {
    name                 = "web-subnet"
    resource_group_name  = "alime-uat-rg"
    virtual_network_name = "vnet-uat-spoke"
    address_prefixes     = ["10.53.1.0/24"]
  }
  app = {
    name                 = "app-subnet"
    resource_group_name  = "alime-uat-rg"
    virtual_network_name = "vnet-uat-spoke"
    address_prefixes     = ["10.53.2.0/24"]
  }
  db = {
    name                 = "db-subnet"
    resource_group_name  = "alime-uat-rg"
    virtual_network_name = "vnet-uat-spoke"
    address_prefixes     = ["10.53.3.0/24"]
  }
}