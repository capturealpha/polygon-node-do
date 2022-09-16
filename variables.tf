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

variable "polygon_network_name" {
  description = "Polygon node network (mainnet, mumbai, local)"
  default     = "mumbai"
}

variable "polygon_network_code" {
  description = "Polygon node network code (mainnet-v1, testnet-v4)"
  default     = "testnet-v4"
}

variable "bor_mode" {
  description = "Bor mode (archive, fullnode)"
  default     = "archive"
}

variable "eth_rpc_url" {
  description = "RPC endpoint for ethereum chain"
  default     = "http://localhost:8545"
}

variable "heimdall_seeds" {
  description = "Seed nodes for heimdall"
  # mumbai
  default     = "4cd60c1d76e44b05f7dfd8bab3f447b119e87042@54.147.31.250:26656,b18bbe1f3d8576f4b73d9b18976e71c65e839149@34.226.134.117:26656"
  # mainnet
  #default     = "f4f605d60b8ffaaf15240564e58a81103510631c@159.203.9.164:26656,4fb1bc820088764a564d4f66bba1963d47d82329@44.232.55.71:26656"
}

variable "bor_bootnodes" {
  description = "Bor bootnodes"
  default     = "enode://095c4465fe509bd7107bbf421aea0d3ad4d4bfc3ff8f9fdc86f4f950892ae3bbc3e5c715343c4cf60c1c06e088e621d6f1b43ab9130ae56c2cacfd356a284ee4@18.213.200.99:30303"
}