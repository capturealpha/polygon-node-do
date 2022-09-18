resource "digitalocean_ssh_key" "default" {
  name       = var.node_droplet_name
  public_key = file(var.public_key_path)
}