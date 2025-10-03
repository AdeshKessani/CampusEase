data "aws_ssm_parameter" "campusease_ingress_sg_id" {
  name = "/${var.campusease_name}/${var.env}/ingress_sg_id"
}

data "aws_ssm_parameter" "campusease_public_subnet_ids" {
  name = "/${var.campusease_name}/${var.env}/public_subnet_ids"
}

data "aws_ssm_parameter" "campusease_acm_certificate_arn" {
  name = "/${var.campusease_name}/${var.env}/acm_certificate_arn"
}

data "aws_ssm_parameter" "campusease_vpc_id" {
  name = "/${var.campusease_name}/${var.env}/vpc_id"
}
