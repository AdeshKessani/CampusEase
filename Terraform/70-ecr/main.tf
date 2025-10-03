resource "aws_ecr_repository" "campusease_backend" {
  name                 = "${var.campusease_name}-backend"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "campusease_frontend" {
  name                 = "${var.campusease_name}-frontend"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
