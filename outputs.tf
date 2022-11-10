output "id" {
  value       = azurerm_logic_app_workflow.this.id
  description = "The ID of the Logic App."
}

output "identity" {
  value       = azurerm_logic_app_workflow.this.identity[*]
  description = "Function app Managed Identity"
}
