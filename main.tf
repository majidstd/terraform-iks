
provider "intersight" {
  apikey    = var.intersight_apikey
  secretkey = var.intersight_secretkey
  endpoint  = var.intersight_endpoint
}

module "iks" {

  source  = "terraform-cisco-modules/iks/intersight"
  version = "~>2.3.0"

# Kubernetes Cluster Profile  Adjust the values as needed.
  cluster = {
    name                = "iks-cluster01"
    action              = "Deploy"
    wait_for_completion = false
    worker_nodes        = 3
    load_balancers      = 3
    worker_max          = 4
    control_nodes       = 1
    ssh_user            = var.iks_ssh_user
    ssh_public_key      = var.iks_ssh_key
  }


# IP Pool Information (To create new change "use_existing" to 'false' uncomment variables and modify them to meet your needs.)
  ip_pool = {
    use_existing    = false
    create_new   		= true
    name                = "192-168-52-160-191"
    ip_starting_address = "192.168.52.161"
    ip_pool_size        = "30"
    ip_netmask          = "255.255.255.0"
    ip_gateway          = "192.168.52.254"
    dns_servers         = ["192.168.51.129","8.8.8.8"]
  }

# Sysconfig Policy (UI Reference NODE OS Configuration) (To create new change "use_existing" to 'false' uncomment variables and modify them to meet your needs.)
  sysconfig = {
    use_existing = false
    create_new   = true
    name         = "iks-cluster01-sys-config-policy"
    domain_name  = "bispass.com"
    timezone     = "America/Los_Angeles"
    ntp_servers  = ["192.168.51.129"]
    dns_servers  = ["192.168.51.129"]
  }

# Kubernetes Network CIDR (To create new change "use_existing" to 'false' uncomment variables and modify them to meet your needs.)
  k8s_network = {
    use_existing = false
    create_new   = true
    name         = "iks-cluster01-network-policy"

    ######### Below are the default settings.  Change if needed. #########
    pod_cidr     = "100.64.0.0/16"
    service_cidr = "100.65.0.0/24"
    cni          = "Calico"
  }
# Version policy (To create new change "useExisting" to 'false' uncomment variables and modify them to meet your needs.)
  versionPolicy = {
    useExisting = false
    create_new   	= true
    policyName     	= "1.21.11-iks.2"
    iksVersionName 	= "1.21.11-iks.2"
  }
# Trusted Registry Policy (To create new change "use_existing" to 'false' and set "create_new' to 'true' uncomment variables and modify them to meet your needs.)
# Set both variables to 'false' if this policy is not needed.
  tr_policy = {
    use_existing = false
    create_new   = false
    name         = "trusted-registry"
  }
# Runtime Policy (To create new change "use_existing" to 'false' and set "create_new' to 'true' uncomment variables and modify them to meet your needs.)
# Set both variables to 'false' if this policy is not needed.
  runtime_policy = {
    use_existing = false
    create_new   = false
    # name                 = "runtime"
    # http_proxy_hostname  = "t"
    # http_proxy_port      = 80
    # http_proxy_protocol  = "http"
    # http_proxy_username  = null
    # http_proxy_password  = null
    # https_proxy_hostname = "t"
    # https_proxy_port     = 8080
    # https_proxy_protocol = "https"
    # https_proxy_username = null
    # https_proxy_password = null
  }

# Infrastructure Configuration Policy (To create new change "use_existing" to 'false' and uncomment variables and modify them to meet your needs.)
  infraConfigPolicy = {
    use_existing = false
    createNew = true
    platformType = "esxi"
    targetName   = "vcenter01.bitpass.com"
    policyName   = "bit-vcenter01"
    description  = "bit-vcenter01"
	interfaces   = ["BIT-DVS01-VLAN52"]
    vcClusterName      = "General"
    vcDatastoreName    = "esx01-datastore1"
    vcPassword         = var.vcPassword
    vcResourcePoolName = ""
  }

# Addon Profile and Policies (To create new change "createNew" to 'true' and uncomment variables and modify them to meet your needs.)
# This is an Optional item.  Comment or remove to not use.  Multiple addons can be configured.
  addons       = [
    {
    createNew = true
    addonPolicyName = "smm-tf"
    addonName            = "smm"
    description       = "SMM Policy"
    upgradeStrategy  = "AlwaysReinstall"
    installStrategy  = "InstallOnly"
    #releaseVersion = "1.7.4-cisco4-helm3"
    overrides = yamlencode({"demoApplication":{"enabled":true}})
    },
    # {
    # createNew = true
    # addonName            = "ccp-monitor"
    # description       = "monitor Policy"
    # # upgradeStrategy  = "AlwaysReinstall"
    # # installStrategy  = "InstallOnly"
    # releaseVersion = "0.2.61-helm3"
    # # overrides = yamlencode({"demoApplication":{"enabled":true}})
    # }
  ]

# Worker Node Instance Type (To create new change "use_existing" to 'false' and uncomment variables and modify them to meet your needs.)
  instance_type = {
    use_existing = false
    create_new   = true
    name         = "small"
    cpu          = 4
    memory       = 16386
    disk_size    = 40
  }

# Organization and Tag Information
  organization = var.organization
  tags         = var.tags
}
