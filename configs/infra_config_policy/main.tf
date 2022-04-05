provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

#Policy Example for IWE
# module "iwe" {
  # source  = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  # version = "2.0.4"
  # vmConfig = {
    # platformType = "iwe"
    # targetName   = "falcon"
    # policyName   = "iwe-test"
    # description  = "Test Policy"
    # interfaces   = ["iwe-guests"]
  # }

  # org_name = var.organization
  # tags     = var.tags
# }
#Policy Example for Vcenter
module "vcenter" {
  source = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  vmConfig = {
    platformType       = "esxi"
    targetName         = "vcenter01.bitpass.com"
    policyName         = "bit-vcenter01"
    description        = "bit-vcenter01"
    interfaces         = ["BIT-VLAN52"]
    vcClusterName      = "General"
    vcDatastoreName    = "esx01-datastore1"
    vcPassword         = var.vcPassword
    vcResourcePoolName = ""
  }

  org_name = var.organization
  tags     = var.tags
}


