provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "192-168-52-160-191" {
  source           = "terraform-cisco-modules/iks/intersight//modules/ip_pool"
  name             = "192-168-52-160-191"
  starting_address = "192.168.52.160"
  pool_size        = "30"
  ending_address   = "192.168.52.191"
  netmask          = "255.255.255.0"
  gateway          = "192.168.52.254"
  primary_dns      = "192.168.51.129"
  secondary_dns    = "8.8.8.8"

  org_name = var.organization
  tags     = var.tags
}