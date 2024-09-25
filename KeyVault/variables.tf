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

variable "sa_accesskey_name" {
  type        = string
  description = "Storage Account Access Key name (inherited from StorageAccount module)"
}

variable "sa_accesskey_value" {
  type        = string
  description = "Storage Account Access Key value  (inherited from StorageAccount module)"
}