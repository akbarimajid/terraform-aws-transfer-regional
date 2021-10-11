data "aws_route53_zone" "selected" {
  name         = "example.com."
  private_zone = false
}

resource "aws_route53_record" "route53_record" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "sftp"
  type    = "CNAME"
  ttl     = "600"
  records = ["${aws_transfer_server.sftp.endpoint}"]
  set_identifier = "Global SFTP ${data.aws_region.current.name}"

  latency_routing_policy {
    region         = "${data.aws_region.current.name}"
  }
}