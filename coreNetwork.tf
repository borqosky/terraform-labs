resource "azurerm_resource_group" "core" {
  name     = "core"
  location = "${var.loc}"
  tags     = "${var.tags}"
}

resource "azurerm_public_ip" "vpnGatewayPublicIp" {
  name                = "vpnGatewayPublicIp"
  resource_group_name = "${azurerm_resource_group.core.name}"
  location            = "${azurerm_resource_group.core.location}"
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network" "core" {
  name                = "core" 
  resource_group_name = "${azurerm_resource_group.core.name}"
  location            = "${azurerm_resource_group.core.location}"
  address_space       = ["10.0.0.0/16"] 
  dns_servers         = ["1.1.1.1", "1.0.0.1"]
}

resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet" 
  resource_group_name  = "${azurerm_resource_group.core.name}"
  virtual_network_name = "${azurerm_virtual_network.core.name}"
  address_prefix       = "10.0.0.0/24"
}

resource "azurerm_subnet" "training" {
  name                 = "training" 
  resource_group_name  = "${azurerm_resource_group.core.name}"
  virtual_network_name = "${azurerm_virtual_network.core.name}"
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_subnet" "dev" {
  name                 = "dev" 
  resource_group_name  = "${azurerm_resource_group.core.name}"
  virtual_network_name = "${azurerm_virtual_network.core.name}"
  address_prefix       = "10.0.2.0/24"
}
/*
resource "azurerm_virtual_network_gateway" "vpnGateway" {
  name                 = "vpnGateway" 
  location             = "${azurerm_resource_group.core.location}"
  resource_group_name  = "${azurerm_resource_group.core.name}"
  
  sku                  = "Basic"
  enable_bgp           = true
  
  type                 = "Vpn"
  vpn_type             = "RouteBased"
  
  ip_configuration {
    name                          = "vpnGwConfig1"
    public_ip_address_id          = "${azurerm_public_ip.vpnGatewayPublicIp.id}"
    subnet_id                     = "${azurerm_subnet.GatewaySubnet.id}"
    private_ip_address_allocation = "Dynamic"
  } 
}
*/