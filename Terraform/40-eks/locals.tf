locals {
  private_subnet_ids = data.aws_ssm_parameter.campusease_private_subnet_ids.value
  cluster_sg_id      = data.aws_ssm_parameter.campusease_cluster_sg_id.value
  node_sg_id         = data.aws_ssm_parameter.campusease_node_sg_id.value
  vpc_id             = data.aws_ssm_parameter.campusease_vpc_id.value
}
