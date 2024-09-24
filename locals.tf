locals {
  common_tags = {
    company_name = var.company_name
    costcenter   = var.costcenter
    project_name = var.project_name
    environment  = var.environment
  }
}