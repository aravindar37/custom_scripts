# resource "aws_route53_zone" "k8s-dns-zone" {
#   name = var.dns-domain
# }

# resource "aws_route53_record" "public" {
#   for_each = {for i, v in aws_instance.k8s-node: i=>v}
#   zone_id  = aws_route53_zone.k8s-dns-zone.zone_id
#   name     = "ex${each.value.tags.Name}.${substr(var.dns-domain, 0, length(var.dns-domain))}"
#   type     = "A"
#   ttl      = "300"
#   records  = [each.value.public_ip]
# }

# resource "aws_route53_record" "private" {
#   for_each = {for i, v in aws_instance.k8s-node: i=>v}
#   zone_id  = aws_route53_zone.k8s-dns-zone.zone_id
#   name     = "${each.value.tags.Name}.${substr(var.dns-domain, 0, length(var.dns-domain))}"
#   type     = "A"
#   ttl      = "300"
#   records  = [each.value.private_ip]
# }

