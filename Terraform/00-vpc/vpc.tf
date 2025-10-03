module "campusease_vpc" {
  # Example: custom VPC module source for project
  source = "git::https://github.com/adeshkessani/terraform-aws-vpc.git"

  project_name = var.campusease_name
  common_tags  = var.campus_tags
  public_subnet_cidrs   = var.campus_public_cidrs
  private_subnet_cidrs  = var.campus_private_cidrs
  database_subnet_cidrs = var.campus_db_cidrs
  is_peering_required   = var.peering_enabled
}
