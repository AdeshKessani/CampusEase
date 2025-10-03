module "db" {
  source        = "git::https://github.com/adeshkessani/terraform-aws-securitygroups.git"
  project_name  = var.campusease_name
  environment   = var.env
  sg_description = "SG for DB MySQL Instances"
  vpc_id        = data.aws_ssm_parameter.campusease_vpc_id.value
  common_tags   = var.campus_tags
  sg_name       = "db"
}

module "ingress" {
  source        = "git::https://github.com/adeshkessani/terraform-aws-securitygroups.git"
  project_name  = var.campusease_name
  environment   = var.env
  sg_description = "SG for Ingress controller"
  vpc_id        = data.aws_ssm_parameter.campusease_vpc_id.value
  common_tags   = var.campus_tags
  sg_name       = "ingress"
}

module "cluster" {
  source        = "git::https://github.com/adeshkessani/terraform-aws-securitygroups.git"
  project_name  = var.campusease_name
  environment   = var.env
  sg_description = "SG for EKS Control plane"
  vpc_id        = data.aws_ssm_parameter.campusease_vpc_id.value
  common_tags   = var.campus_tags
  sg_name       = "eks-control-plane"
}

module "node" {
  source        = "git::https://github.com/adeshkessani/terraform-aws-securitygroups.git"
  project_name  = var.campusease_name
  environment   = var.env
  sg_description = "SG for EKS node"
  vpc_id        = data.aws_ssm_parameter.campusease_vpc_id.value
  common_tags   = var.campus_tags
  sg_name       = "eks-node"
}

module "bastion" {
  source        = "git::https://github.com/adeshkessani/terraform-aws-securitygroups.git"
  project_name  = var.campusease_name
  environment   = var.env
  sg_description = "SG for Bastion Instances"
  vpc_id        = data.aws_ssm_parameter.campusease_vpc_id.value
  common_tags   = var.campus_tags
  sg_name       = "bastion"
}

module "vpn" {
  source        = "git::https://github.com/adeshkessani/terraform-aws-securitygroups.git"
  project_name  = var.campusease_name
  environment   = var.env
  sg_description = "SG for VPN Instances"
  vpc_id        = data.aws_ssm_parameter.campusease_vpc_id.value
  common_tags   = var.campus_tags
  sg_name       = "vpn"
  ingress_rules = var.vpn_sg_rules
}

resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

resource "aws_security_group_rule" "cluster_bastion" {
  type                    = "ingress"
  from_port               = 443
  to_port                 = 443
  protocol                = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id       = module.cluster.sg_id
}

resource "aws_security_group_rule" "cluster_node" {
  type                    = "ingress"
  from_port               = 0
  to_port                 = 65535
  protocol                = "-1"
  source_security_group_id = module.node.sg_id
  security_group_id       = module.cluster.sg_id
}

resource "aws_security_group_rule" "node_cluster" {
  type                    = "ingress"
  from_port               = 0
  to_port                 = 65535
  protocol                = "-1"
  source_security_group_id = module.cluster.sg_id
  security_group_id       = module.node.sg_id
}

resource "aws_security_group_rule" "node_vpc" {
  type          = "ingress"
  from_port     = 0
  to_port       = 65535
  protocol      = "-1"
  cidr_blocks   = ["10.0.0.0/16"]
  security_group_id = module.node.sg_id
}

resource "aws_security_group_rule" "db_bastion" {
  type                    = "ingress"
  from_port               = 3306
  to_port                 = 3306
  protocol                = "TCP"
  source_security_group_id = module.bastion.sg_id
  security_group_id       = module.db.sg_id
}

resource "aws_security_group_rule" "db_node" {
  type                    = "ingress"
  from_port               = 3306
  to_port                 = 3306
  protocol                = "TCP"
  source_security_group_id = module.node.sg_id
  security_group_id       = module.db.sg_id
}

resource "aws_security_group_rule" "ingress_public_https" {
  type           = "ingress"
  from_port      = 443
  to_port        = 443
  protocol       = "TCP"
  cidr_blocks    = ["0.0.0.0/0"]
  security_group_id = module.ingress.sg_id
}

resource "aws_security_group_rule" "ingress_public_http" {
  type           = "ingress"
  from_port      = 80
  to_port        = 80
  protocol       = "TCP"
  cidr_blocks    = ["0.0.0.0/0"]
  security_group_id = module.ingress.sg_id
}

resource "aws_security_group_rule" "node_ingress" {
  type                    = "ingress"
  from_port               = 30000
  to_port                 = 32768
  protocol                = "TCP"
  source_security_group_id = module.ingress.sg_id
  security_group_id       = module.node.sg_id
}
