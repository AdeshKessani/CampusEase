variable "campusease_name" {
  default = "campusease"
}

variable "env" {
  default = "dev"
}

variable "campus_tags" {
  default = {
    Project     = "campusease"
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "zone_name" {
  default = "campusease.site"
}
