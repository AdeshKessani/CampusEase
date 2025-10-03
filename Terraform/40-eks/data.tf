data "aws_ssm_parameter" "campusease_vpc_id" {
  name = "/${var.campusease_name}/${var.env}/vpc_id"
}

data "aws_ssm_parameter" "campusease_cluster_sg_id" {
  name = "/${var.campusease_name}/${var.env}/cluster_sg_id"
}

data "aws_ssm_parameter" "campusease_node_sg_id" {
  name = "/${var.campusease_name}/${var.env}/node_sg_id"
}

data "aws_ssm_parameter" "campusease_private_subnet_ids" {
  name = "/${var.campusease_name}/${var.env}/private_subnet_ids"
}

data "aws_vpc" "default" {
  default = true
}
