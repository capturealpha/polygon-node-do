variable "do_token" {
  description = "DO API token"
}

variable "prefix" {
  description = "Name of project being deployed for naming and tagging"
  default     = "polygon"
}

variable "ssh_port" {
  description = "sshd daemon listening port"
  default     = "22"
}

variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.

Example: ~/.ssh/terraform.pub
DESCRIPTION

  default = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = <<DESCRIPTION
Path to the SSH private key to be used for authentication.

Example: ~/.ssh/id_rsa
DESCRIPTION

  default = "~/.ssh/id_rsa"
}

variable "root_domain" {
  description = "DNS root domain lookup"
}

variable "ip_whitelist" {
  description = "List of ip/cidr to be whitelisted for each droplet"
}

variable "ssh_key_1" {
  description = "ssh key to add to allowed_hosts"
}

variable "ssh_key_2" {
  description = "ssh key to add to allowed_hosts"
}

variable "droplet_size" {
  description = "The unique slug that indentifies the type of droplet. You can find a list of available slugs on https://docs.digitalocean.com/reference/api/api-reference/#tag/Sizes"
  default     = "s-4vcpu-8gb-amd"
}

variable "droplet_region" {
  description = "The region to start the droplet in"
}

variable "droplet_name" {
  description = "The droplet name"
}

variable "droplet_image" {
  description = "The droplet OS image"
  default     = "ubuntu-22-04-x64"
}

variable "data_volume_size" {
  description = "The polygon data volume size"
  default     = 500
}

variable "data_volume_name" {
  description = "The polygon data volume name"
  default     = "data"
}

variable "data_volume_fs_type" {
  description = "The polygon data volume filesystem type (xfs or ext4) for the block storage volume"
  default     = "xfs"
}

variable "polygon_chain" {
  description = "Chain of polygon node (mainnet, mumbai, local)"
  default     = "mumbai"
}

variable "eth_rpc_url" {
  description = "RPC endpoint for ethereum chain"
  default     = "mumbai"
}