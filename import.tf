resource "azurerm_resource_group" "deleteme" {
  location = "${var.loc}"
  name     = "deleteme"
  tags     = "${var.tags}"
}
