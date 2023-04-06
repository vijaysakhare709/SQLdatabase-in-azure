terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "api-rg-pro"
  location = "West Europe"
}

resource "azurerm_mssql_server" "example" {
  name                         = "vijay"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "mradministrator"
  administrator_login_password = "thisIsDog1123"

  depends_on = [
    azurerm_resource_group.example
  ]
}

resource "azurerm_mssql_database" "test" {
  name           = "acctest-dvijayb-d"
  server_id      = azurerm_mssql_server.example.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  read_scale     = true
  sku_name       = "Basic"
  
depends_on = [
    azurerm_mssql_server.example
]

}


resource "azurerm_sql_firewall_rule" "example" {
  name                = "FirewallRulvijaye1"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mssql_server.example.name
  start_ip_address    = "10.0.17.62"    # yaha tumhe ip dena honga pahile ek mannual kr ke waha client ka ip
  end_ip_address      = "10.0.17.62"    # same

  depends_on = [
    azurerm_mssql_server.example
  ]
}
