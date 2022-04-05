provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "1.20.14-iks.1" {
  source         = "terraform-cisco-modules/iks/intersight//modules/version"
  policyName     = "1.20.14-iks.1"
  iksVersionName = "1.20.14-iks.1"

  org_name = var.organization
  tags     = var.tags
}
