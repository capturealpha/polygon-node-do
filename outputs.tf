output "node-ip" {
  value = digitalocean_droplet.polygon.ipv4_address
}
output "prefix" {
  value = var.prefix
}