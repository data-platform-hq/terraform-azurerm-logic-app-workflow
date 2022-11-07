resource "azurerm_logic_app_workflow" "this" {
  name                = "lapp-${var.project}-${var.env}-${var.location}-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group
  tags                = var.tags
}
