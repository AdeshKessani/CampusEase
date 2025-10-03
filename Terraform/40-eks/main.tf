resource "aws_key_pair" "eks" {
  key_name   = "campusease-eks-key"
  # Place your SSH public key here, or reference a file path
  # public_key = "ssh-ed25519 AAAAC3NzaC1lZD..."
  public_key = file("c:/repos/campusease-key-pair.pub")
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name                    = "${var.campusease_name}-${var.env}"
  cluster_version                 = "1.30"
  cluster_endpoint_public_access  = true

  vpc_id                         = local.vpc_id
  subnet_ids                     = split(",", local.private_subnet_ids)
  control_plane_subnet_ids       = split(",", local.private_subnet_ids)

  create_cluster_security_group  = false
  cluster_security_group_id      = local.cluster_sg_id

  create_node_security_group     = false
  node_security_group_id         = local.node_sg_id

  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    green = {
      min_size      = 2
      max_size      = 10
      desired_size  = 2
      capacity_type = "SPOT"
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonElasticFileSystemFullAccess = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
        ElasticLoadBalancingFullAccess    = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
      }
      key_name = aws_key_pair.eks.key_name
    }
  }

  tags = var.campus_tags
}
