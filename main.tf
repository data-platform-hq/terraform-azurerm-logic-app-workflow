locals {
  workflow_parameters = {
    for k, v in var.workflow_parameters : k => jsonencode(v)
  }
  parameters = {
    for k, v in var.parameters : k => jsonencode(v)
  }
}

resource "azurerm_logic_app_workflow" "this" {
  name                = "lapp-${var.project}-${var.env}-${var.location}-${var.name}"
  location            = var.location
  parameters          = local.parameters
  resource_group_name = var.resource_group
  tags                = var.tags
  workflow_parameters = local.workflow_parameters
  identity {
    type         = var.identity_ids == null ? "SystemAssigned" : "SystemAssigned, UserAssigned"
    identity_ids = var.identity_ids
  }
}
