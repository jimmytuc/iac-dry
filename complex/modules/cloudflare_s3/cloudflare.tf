data "cloudflare_zones" "domain" {
  filter {
    name = "domain.io"
  }
}

resource "cloudflare_record" "site_cname" {
  depends_on = [aws_cloudfront_distribution.dist]

  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.domain
  value   = aws_cloudfront_distribution.dist.domain_name
  type    = "CNAME"
}
