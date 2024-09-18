# STORAGE ACCOUNT variables

variable "project_name" {
  type        = string
  description = "Project name used for all resources"
  default     = "opera-terra-project"
}

variable "rg_name" {
  type        = string
  description = "Name of Resource group"
}

variable "location" {
  type        = string
  description = "Location used for resource hosting"
  default     = "westeurope"
}

variable "environment" {
  type        = string
  description = "Deployment status used for custom provisioning"
  default     = "dev"
}

variable "costcenter" {
  type        = string
  description = "Department name used for accounting"
  default     = "IT"

}

# Inheriting variables

variable "common_tags" {
  type        = map(string)
  description = "Common tags for the resources in this module (inherited from locals)"
}

variable "vm_names" {
  type        = list(string)
  description = "Virtual Machine names (inherited from VirtualMachine module)"
}

variable "subnet_ids" {
  type        = set(string)
  description = "Set of subnet IDs (inherited from Network module)"
}