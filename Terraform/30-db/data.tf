data "aws_ssm_parameter" "campusease_db_sg_id" {
  name = "/${var.campusease_name}/${var.env}/db_sg_id"
}

data "aws_ssm_parameter" "campusease_db_subnet_group_name" {
  name = "/${var.campusease_name}/${var.env}/db_subnet_group_name"
}
