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

# Inheriting variables

variable "project_name" {
  type        = string
  description = "Project name used for all resources (inherited from StorageAccount module)"
  default     = "opera-terra-project"
}

variable "rg_name" {
  type        = string
  description = "Name of Resource group (inherited from StorageAccount module)"
}

variable "location" {
  type        = string
  description = "Location used for resource hosting (inherited from StorageAccount module)"
  default     = "westeurope"
}

variable "vm_names" {
  type        = list(string)
  description = "Virtual Machine names (inherited from VirtualMachine module)"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags for the resources in this module (inherited from locals)"
}