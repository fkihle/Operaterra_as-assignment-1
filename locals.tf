locals {
  common_tags = {
    company_name = var.company_name
    costcenter   = module.ResourceGroup.costcenter
    project_name = module.ResourceGroup.project_name
    environment  = module.ResourceGroup.environment
  }
}