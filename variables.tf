variable "project" {
  type        = string
  description = "Project name"
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
}

variable "resource_group" {
  type        = string
  description = "Resource group name"
}

variable "name" {
  type        = string
  description = "Logic app name"
}

variable "workflow_parameters" {
  type        = map(string)
  description = "Workflow parameters"
  default     = {}
}

variable "parameters" {
  type        = map(string)
  description = "Parameters"
  default     = {}
}

variable "identity_ids" {
  type        = list(string)
  description = "List of user assigned identity IDs"
  default     = null
}
