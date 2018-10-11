resource "random_id" "rg_name" {
  byte_length = 8
}

resource "azurerm_resource_group" "rg" {
  name     = "${random_id.rg_name.hex}"
  location = "${var.location}"
}
