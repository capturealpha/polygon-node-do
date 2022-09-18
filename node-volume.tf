resource "digitalocean_volume" "data" {
  region                   = var.node_droplet_region
  name                     = var.node_data_volume_name
  size                     = var.node_data_volume_size
  initial_filesystem_type  = var.node_data_volume_fs_type
  initial_filesystem_label = "${var.prefix}-data"
  description              = "${var.prefix} ${var.polygon_network_name} data volume"
  tags                     = ["${var.prefix}-node-${var.polygon_network_name}-data"]
}