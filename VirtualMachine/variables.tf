# VIRTUAL MACHINE variables

variable "vm_names" {
  type        = list(string)
  description = "Virtual Machine names"
  default     = ["VM-01"]
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

variable "common_tags" {
  type        = map(string)
  description = "Common tags for the resources in this module (inherited from locals)"
}

variable "nic_ids" {
  type        = list(string)
  description = "Network Interface IDs (inherited from Network Module)"
}

variable "admin_user" {
  type        = string
  description = "Randomly generated username (inherited from Key Vault)"
  sensitive   = true
}

variable "admin_pass" {
  type        = string
  description = "Randomly generated password (inherited from Key Vault)"
  sensitive   = true
}