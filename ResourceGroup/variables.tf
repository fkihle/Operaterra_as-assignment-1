# RESOURCE GROUP variables

variable "project_name" {
  type        = string
  description = "Project name used for all resources"
  default     = "opera-terra-project"
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
}

# Inheriting variables

variable "common_tags" {
  type        = map(string)
  description = "Common tags for the resources in this module (inherited from locals)"
}