# If you manage DNS in Digital Ocean and uncomment the blocks below 
# Comment or remove Cloudflare DNS blocks below & provider in main.tf

/* resource "digitalocean_domain" "default" {
  name       = "${var.prefix}-${var.polygon_network_name}.${var.root_domain}"
  ip_address = digitalocean_reserved_ip.primary.ip_address
}
resource "digitalocean_domain" "cadvisor" {
  name       = "cadvisor.${var.prefix}-${var.polygon_network_name}.${var.root_domain}"
  ip_address = digitalocean_reserved_ip.primary.ip_address
}
resource "digitalocean_domain" "server-metrics" {
  name       = "server-metrics.${var.prefix}-${var.polygon_network_name}.${var.root_domain}"
  ip_address = digitalocean_reserved_ip.primary.ip_address
}
resource "digitalocean_domain" "heimdall-metrics" {
  name       = "server-metrics.${var.prefix}-${var.polygon_network_name}.${var.root_domain}"
  ip_address = digitalocean_reserved_ip.primary.ip_address
}
resource "digitalocean_domain" "bor-metrics" {
  name       = "server-metrics.${var.prefix}-${var.polygon_network_name}.${var.root_domain}"
  ip_address = digitalocean_reserved_ip.primary.ip_address
} */

# Cloudflare DNS 
data "cloudflare_zone" "default" {
  name = var.root_domain
}
resource "cloudflare_record" "default" {
  name    = "${var.prefix}-${var.polygon_network_name}.${var.root_domain}"
  value   = digitalocean_reserved_ip.primary.ip_address
  type    = "A"
  zone_id = data.cloudflare_zone.default.zone_id
}
resource "cloudflare_record" "cadvisor" {
  name    = "cadvisor.${var.prefix}-${var.polygon_network_name}.${var.root_domain}"
  value   = digitalocean_reserved_ip.primary.ip_address
  type    = "A"
  zone_id = data.cloudflare_zone.default.zone_id
}
resource "cloudflare_record" "server-metrics" {
  name    = "server-metrics.${var.prefix}-${var.polygon_network_name}.${var.root_domain}"
  value   = digitalocean_reserved_ip.primary.ip_address
  type    = "A"
  zone_id = data.cloudflare_zone.default.zone_id
}
resource "cloudflare_record" "heimdall-metrics" {
  name    = "heimdall-metrics.${var.prefix}-${var.polygon_network_name}.${var.root_domain}"
  value   = digitalocean_reserved_ip.primary.ip_address
  type    = "A"
  zone_id = data.cloudflare_zone.default.zone_id
}
resource "cloudflare_record" "bor-metrics" {
  name    = "bor-metrics.${var.prefix}-${var.polygon_network_name}.${var.root_domain}"
  value   = digitalocean_reserved_ip.primary.ip_address
  type    = "A"
  zone_id = data.cloudflare_zone.default.zone_id
}