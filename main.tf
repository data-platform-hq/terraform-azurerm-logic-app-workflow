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
    type         = var.identity_ids == null ? "SystemAssigned" : "UserAssigned"
    identity_ids = var.identity_ids
  }
}

data "azurerm_monitor_diagnostic_categories" "this" {
  count       = var.enable_diagnostic_setting ? 1 : 0
  resource_id = azurerm_logic_app_workflow.this.id
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count                          = var.enable_diagnostic_setting ? 1 : 0
  name                           = "lapp-${var.project}-${var.env}-${var.location}-${var.name}"
  target_resource_id             = azurerm_logic_app_workflow.this.id
  log_analytics_workspace_id     = var.analytics_workspace_id
  log_analytics_destination_type = var.analytics_destination_type

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[0].log_category_types
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[0].metrics
    content {
      category = metric.value
    }
  }
  lifecycle {
    ignore_changes = [log_analytics_destination_type] # TODO remove when issue is fixed: https://github.com/Azure/azure-rest-api-specs/issues/9281
  }
}
