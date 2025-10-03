data "aws_ssm_parameter" "campusease_vpc_id" {
  name = "/${var.campusease_name}/${var.env}/vpc_id"
}
