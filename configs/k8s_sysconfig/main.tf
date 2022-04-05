provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "bit-lab" {
  source      = "terraform-cisco-modules/iks/intersight//modules/k8s_sysconfig"
  policy_name = "prod"
  dns_servers = ["192.168.51.129"]
  ntp_servers = ["192.168.51.129"]
  domain_name = "bitpass.com"
  timezone    = "America/Los_Angeles"
  org_name    = var.organization
  tags        = var.tags
}

