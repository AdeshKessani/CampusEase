variable "campusease_name" {
  default = "campusease"
}

variable "env" {
  default = "dev"
}

variable "campus_tags" {
  default = {
    Project   = "campusease"
    Environment = "dev"
    Terraform = "true"
    Component = "ingress-alb"
  }
}

variable "zone_name" {
  default = "campusease.site"
}

variable "zone_id" {
  default = "Z049815217OT8LASP86LW"
}
