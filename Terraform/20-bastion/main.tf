module "campusease_bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.campusease_name}-${var.env}-bastion"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.campusease_bastion_sg_id.value]

  subnet_id = local.public_subnet_id
  ami       = data.aws_ami.ami_info.id
  user_data = file("bastion.sh")

  tags = merge(
    var.campus_tags,
    {
      Name = "${var.campusease_name}-${var.env}-bastion"
    }
  )
}
