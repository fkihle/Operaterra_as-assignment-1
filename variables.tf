# DEPENDENCY variables

variable "subscription_id" {
  type        = string
  description = "The subscription GUID for connection to Azure tennant"
  default     = "https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription"
}

variable "company_name" {
  type        = string
  description = "Company name"
}

# Inheriting variables

variable "costcenter" {
  type        = string
  description = "Department name used for accounting (inherited from ResourceGroup module)"
  default     = "IT"
}

variable "project_name" {
  type        = string
  description = "Project name used for all resources (inherited from ResourceGroup module)"
  default     = "opera-terra-project"
}

variable "environment" {
  type        = string
  description = "Deployment status used for custom provisioning (inherited from ResourceGroup module)"
  default     = "dev"
}
