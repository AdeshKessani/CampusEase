resource "aws_acm_certificate" "campusease" {
  domain_name       = "*.campusease.site"
  validation_method = "DNS"

  tags = merge(
    var.campus_tags,
    {
      Name = "${var.campusease_name}-${var.env}"
    }
  )
}

resource "aws_route53_record" "campusease" {
  for_each = {
    for dvo in aws_acm_certificate.campusease.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 1
  type            = each.value.type
  zone_id         = var.zone_id
}

resource "aws_acm_certificate_validation" "campusease" {
  certificate_arn         = aws_acm_certificate.campusease.arn
  validation_record_fqdns = [for record in aws_route53_record.campusease : record.fqdn]
}
