resource "digitalocean_ssh_key" "default" {
  name       = var.droplet_name
  public_key = file(var.public_key_path)
}

resource "digitalocean_volume" "data" {
  region                   = var.droplet_region
  name                     = var.data_volume_name
  size                     = var.data_volume_size
  initial_filesystem_type  = var.data_volume_fs_type
  initial_filesystem_label = "${var.prefix}-data"
  description              = "${var.prefix} ${var.polygon_network_name} data volume"
  tags                     = ["${var.prefix}-node-${var.polygon_network_name}-data"]
}

resource "digitalocean_droplet" "polygon" {
  image             = var.droplet_image
  name              = var.droplet_name
  region            = var.droplet_region
  size              = var.droplet_size
  graceful_shutdown = true
  monitoring        = false
  backups           = false
  ssh_keys          = [digitalocean_ssh_key.default.fingerprint]
  user_data = templatefile("${abspath(path.root)}/polygon-node-cloud-init.yml", {
    fqdn                 = "${var.prefix}.${var.root_domain}"
    prefix               = var.prefix
    ssh_port             = var.ssh_port
    ssh_key_1            = var.ssh_key_1
    ssh_key_2            = var.ssh_key_2
    data_volume_name     = var.data_volume_name
    polygon_network_name = var.polygon_network_name
    polygon_network_code = var.polygon_network_code
    bor_mode        = var.bor_mode
    eth_rpc_url          = var.eth_rpc_url
    heimdall_seeds       = var.heimdall_seeds
    bor_bootnodes       = var.bor_bootnodes
  })
  connection {
    type        = "ssh"
    user        = var.prefix
    port        = var.ssh_port
    host        = self.ipv4_address
    private_key = file(var.private_key_path)
    agent       = false
  }
  provisioner "file" {
    source      = "./node"
    destination = "/home/${var.prefix}/"
  }
  tags = ["${var.prefix}-node-${var.polygon_network_name}"]
}

resource "digitalocean_volume_attachment" "data" {
  droplet_id = digitalocean_droplet.polygon.id
  volume_id  = digitalocean_volume.data.id
}

resource "digitalocean_reserved_ip" "primary" {
  droplet_id = digitalocean_droplet.polygon.id
  region     = digitalocean_droplet.polygon.region
}
