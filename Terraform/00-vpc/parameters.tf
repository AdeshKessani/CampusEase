# Cloud seat assignment parameters for CampusEase project
resource "aws_ssm_parameter" "campus_vpc_id" {
  name  = "/${var.campusease_name}/${var.env}/vpc_id"
  type  = "String"
  value = module.campusease_vpc.vpc_id
}

resource "aws_ssm_parameter" "campus_public_subnets" {
  name  = "/${var.campusease_name}/${var.env}/public_subnet_identifiers"
  type  = "StringList"
  value = join(",", module.campusease_vpc.public_subnet_ids)
}

resource "aws_ssm_parameter" "campus_private_subnets" {
  name  = "/${var.campusease_name}/${var.env}/private_subnet_identifiers"
  type  = "StringList"
  value = join(",", module.campusease_vpc.private_subnet_ids)
}

resource "aws_ssm_parameter" "db_group_name" {
  name  = "/${var.campusease_name}/${var.env}/db_group_name"
  type  = "String"
  value = module.campusease_vpc.database_subnet_group_name
}
