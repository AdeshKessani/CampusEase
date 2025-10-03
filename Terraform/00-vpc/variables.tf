# Project global variables for the CampusEase infrastructure

variable "campusease_name" {
  default = "campusease"
}

variable "env" {
  default = "development"
}

variable "campus_tags" {
  default = {
    Project = "campusease"
    Environment = "development"
    IaC = "true"
  }
}

variable "campus_public_cidrs" {
  default = ["10.8.0.0/24", "10.8.1.0/24"]
}

variable "campus_private_cidrs" {
  default = ["10.8.10.0/24", "10.8.11.0/24"]
}

variable "campus_db_cidrs" {
  default = ["10.8.20.0/24", "10.8.21.0/24"]
}

variable "peering_enabled" {
  default = true
}
