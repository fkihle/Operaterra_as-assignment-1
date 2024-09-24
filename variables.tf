# DEPENDENCY variables
variable "subscription_id" {
  type        = string
  description = "The subscription GUID for connection to Azure tennant"
  default     = "https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription"
}

# COMMON TAG variables
variable "company_name" {
  type        = string
  description = "Company name"
}

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

# RESOURCE GROUP variables
variable "location" {
  type = string
  description = "Area for hosting the project resources"
  default = "westeurope"
}

# NETWORK variables
variable "vnet_range" {
  type        = string
  description = "Desired virtual network range"
  default     = "10.0.0.0/24"
}

variable "subnet_ranges" {
  type        = list(string)
  description = "List of desired subnet ranges"
  default     = ["10.0.0.0/25", "10.0.0.128/25"]
}

# VIRTUAL MACHINE variables
variable "vm_names" {
  type        = list(string)
  description = "Virtual Machine names"
  default     = ["VM-01"]
}