
terraform {
  backend "azurerm" {
    storage_account_name = "mycompanyterraformstate"
    container_name       = "tfstate"
    key                  = "network/terraform.tfstate"
    access_key           = "your-access-key-here"
  }
}
