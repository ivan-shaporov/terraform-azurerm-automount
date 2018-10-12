# terraform-azurerm-automount


## Automount managed disks

This module creates a VM and automaticallymounts managed disks. 

## Usage


```hcl
resource "random_id" "rg_name" {
  byte_length = 8
}

resource "azurerm_resource_group" "rg" {
  name     = "${random_id.rg_name.hex}"
  location = "${var.location}"
}

module "vm-with-provisioner" {
  source              = "../.."
  location            = "${var.location}"
  vm_os_simple        = "UbuntuServer"
  public_ip_dns       = ["testautomount"] // change to a unique name per datacenter region
  public_ip_address_allocation = "static" // workaround for the issue with vm dynamic IP-s
  vnet_subnet_id      = "${module.network.vnet_subnets[0]}"
  ssh_key             = "~/.ssh/id_rsa.pub" 
  private_ssh_key     = "~/.ssh/id_rsa" 
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

module "network" {
  source              = "Azure/network/azurerm"
  version             = "~> 1.1.1"
  location            = "${var.location}"
  allow_rdp_traffic   = "true"
  allow_ssh_traffic   = "true"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

```

## Authors

Originally created by [Alexey Bokov](http://github.com/abokov) and [Ivan Shaporov](http://github.com/Ivan-Shaporov)



# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
