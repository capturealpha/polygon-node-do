resource "digitalocean_droplet" "polygon" {
  image             = var.node_droplet_image
  name              = var.node_droplet_name
  region            = var.node_droplet_region
  size              = var.node_droplet_size
  graceful_shutdown = true
  monitoring        = true
  backups           = true
  ssh_keys          = [digitalocean_ssh_key.default.fingerprint]
  timeouts {
    create = "30m"
    delete = "10m"
  }
  user_data = templatefile("${abspath(path.root)}/polygon-node-cloud-init.yml", {
    fqdn                 = "${var.prefix}-${var.polygon_network_name}.${var.root_domain}"
    prefix               = var.prefix
    ssh_port             = var.ssh_port
    ssh_key_1            = var.ssh_key_1
    ssh_key_2            = var.ssh_key_2
    data_volume_name     = var.node_data_volume_name
    polygon_network_name = var.polygon_network_name
    polygon_network_code = var.polygon_network_code
    bor_mode             = var.bor_mode
    eth_rpc_url          = var.eth_rpc_url
    heimdall_seeds       = var.heimdall_seeds
    bor_bootnodes        = var.bor_bootnodes
    caddy_user           = var.caddy_user
    caddy_password       = var.caddy_password
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
  provisioner "remote-exec" {
    inline = ["cloud-init status --wait",
      <<EOF
				find ~ -name '*.sh' | xargs chmod +x
				echo "bash /home/${var.prefix}/node/init.sh"
      EOF
    ]
  }
  tags = ["${var.prefix}-node-${var.polygon_network_name}", "monitoring"]
}

resource "digitalocean_volume_attachment" "data" {
  droplet_id = digitalocean_droplet.polygon.id
  volume_id  = digitalocean_volume.data.id
}

resource "digitalocean_reserved_ip" "primary" {
  droplet_id = digitalocean_droplet.polygon.id
  region     = digitalocean_droplet.polygon.region
}
