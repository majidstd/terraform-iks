


# Intersight Kubernetes Service(IKS) via Terraform

This setup will program intersight Kubernetes templates and configuration to deploy IKS Cluster in the on-premise infrastructure by connecting to VMware Vcenter to deploy infrastructure configuration via Intersight.

The Cisco Intersight Terraform Provider is available in the Terraform Registry at https://registry.terraform.io/providers/CiscoDevNet/intersight/latest.  This repository contains example modules that use the provider to create 

A terraform module to create a managed Kubernetes clusters using Intersight Kubernetes Service (IKS). Available through the [Terraform registry](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest) and its [source code](https://github.com/CiscoDevNet/terraform-provider-intersight).





## Assumptions

* You want to create an IKS cluster on your on-premises infrastructure using Intersight.
* These resources will be provided using Intersight and VMware vCenter 6.7.
* You've claimed vCenter using the Intersight Assist Appliance.

## Details

This module creates all of the resources required for IKS.  Those resources are identitified below.  It is designed as a quickstart/example of how to get an IKS cluster running.  More customization is being enabled but currently there are some caveats:

Reusing prebuilt policies is supported.  Each object block has a variable for doing this.
Set
```hcl
use_existing = true
```
If existing objects are not available this module will create those objects for you where required.
Set
```hcl
use_existing = false
```
For the runtime_policies and the Trusted registry, if you DO NOT want to use this policy in your cluster build you need to set the following variable combination in EACH object block.
```hcl
  use_existing         = false
  create_new           = false
```

## Usage

See the [Examples](https://github.com/terraform-cisco-modules/terraform-intersight-iks/tree/main/examples) ---> Complete directory for usage of this module.

There are 4 example files below that are needed to use this module.  Create these files in the same directory, run terraform init.  You will then be ready to run terraform plan or terraform apply.

Change the variables in the terraform.tfvars file and the main.tf as needed.
See the above Examples folder for more information.


```
Sample terraform.tfvars file.
```hcl
apikey       = ""
secretkey    = "../../.secret"
organization = "default"
ssh_user = "iksadmin"
ssh_key  = ""
tags = [
  {
    "key" : "managed_by"
    "value" : "Terraform"
  },
  {
    "key" : "owner"
    "value" : "jb"
  }
]
organization = "default" # Change this if a different org is required.  Default org is set to "default"
```

Sample versions.tf file
```hcl
terraform {
  required_version = ">=1.1.0"

  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.18"
    }
  }
}
```
Sample variables.tf file.
```hcl
variable "apikey" {
  type        = string
  description = "API Key"
}
variable "secretkey" {
  type        = string
  description = "Secret Key or file location"
}
variable "endpoint" {
  type        = string
  description = "API Endpoint URL"
  default     = "https://www.intersight.com"
}
variable "organization" {
  type        = string
  description = "Organization Name"
  default     = "default"
}
variable "ssh_user" {
  type        = string
  description = "SSH Username for node login."
}
variable "ssh_key" {
  type        = string
  description = "SSH Public Key to be used to node login."
}
variable "tags" {
  type    = list(map(string))
  default = []
}
```

**Always check [Kubernetes Release Notes](https://kubernetes.io/docs/setup/release/notes/) before updating the major version.**


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.18 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | >=1.0.18 |


## Resources

| Name | Type |
|------|------|
| [intersight_ippool_pool.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/ippool_pool) | data source |
| [intersight_kubernetes_container_runtime_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_container_runtime_policy) | data source |
| [intersight_kubernetes_network_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_network_policy) | data source |
| [intersight_kubernetes_sys_config_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_sys_config_policy) | data source |
| [intersight_kubernetes_trusted_registries_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_trusted_registries_policy) | data source |
| [intersight_kubernetes_version_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_version_policy) | data source |
| [intersight_kubernetes_virtual_machine_infra_config_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_virtual_machine_infra_config_policy) | data source |
| [intersight_kubernetes_virtual_machine_instance_type.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_virtual_machine_instance_type) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addons"></a> [addons](#input\_addons) | n/a | <pre>list(object({<br>    createNew        = bool<br>    addonPolicyName  = optional(string)<br>    addonName        = optional(string)<br>    description      = optional(string)<br>    upgradeStrategy  = optional(string)<br>    installStrategy  = optional(string)<br>    overrideSets     = optional(list(map(string)))<br>    overrides        = optional(string)<br>    releaseName      = optional(string)<br>    releaseNamespace = optional(string)<br>    releaseVersion   = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | n/a | <pre>object({<br>    name                = string<br>    action              = string<br>    wait_for_completion = bool<br>    worker_nodes        = number<br>    load_balancers      = number<br>    worker_max          = number<br>    control_nodes       = number<br>    ssh_user            = string<br>    ssh_public_key      = string<br>  })</pre> | n/a | yes |
| <a name="input_infraConfigPolicy"></a> [infraConfigPolicy](#input\_infraConfigPolicy) | n/a | <pre>object({<br>    use_existing       = bool<br>    platformType       = optional(string)<br>    targetName         = optional(string)<br>    policyName         = string<br>    description        = optional(string)<br>    interfaces         = optional(list(string))<br>    diskMode           = optional(string)<br>    vcTargetName       = optional(string)<br>    vcClusterName      = optional(string)<br>    vcDatastoreName    = optional(string)<br>    vcResourcePoolName = optional(string)<br>    vcPassword         = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_infra_config_policy_name"></a> [infra\_config\_policy\_name](#input\_infra\_config\_policy\_name) | Name of existing infra config policy (if it exists) to be used. | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | <pre>object({<br>    use_existing = bool<br>    name         = string<br>    cpu          = optional(number)<br>    memory       = optional(number)<br>    disk_size    = optional(number)<br>  })</pre> | n/a | yes |
| <a name="input_ip_pool"></a> [ip\_pool](#input\_ip\_pool) | n/a | <pre>object({<br>    use_existing        = bool<br>    name                = string<br>    ip_starting_address = optional(string)<br>    ip_pool_size        = optional(string)<br>    ip_netmask          = optional(string)<br>    ip_gateway          = optional(string)<br>    dns_servers         = optional(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_k8s_network"></a> [k8s\_network](#input\_k8s\_network) | n/a | <pre>object({<br>    use_existing = bool<br>    name         = optional(string)<br>    pod_cidr     = optional(string)<br>    service_cidr = optional(string)<br>    cni          = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_k8s_network_policy_name"></a> [k8s\_network\_policy\_name](#input\_k8s\_network\_policy\_name) | Name of existing K8s Network Policy (if it exists) to be used. | `string` | `""` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization Name | `string` | `"default"` | no |
| <a name="input_runtime_policy"></a> [runtime\_policy](#input\_runtime\_policy) | n/a | <pre>object({<br>    use_existing         = bool<br>    create_new           = bool<br>    name                 = optional(string)<br>    http_proxy_hostname  = optional(string)<br>    http_proxy_port      = optional(number)<br>    http_proxy_protocol  = optional(string)<br>    http_proxy_username  = optional(string)<br>    http_proxy_password  = optional(string)<br>    https_proxy_hostname = optional(string)<br>    https_proxy_port     = optional(number)<br>    https_proxy_protocol = optional(string)<br>    https_proxy_username = optional(string)<br>    https_proxy_password = optional(string)<br>    docker_no_proxy      = optional(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_sysconfig"></a> [sysconfig](#input\_sysconfig) | n/a | <pre>object({<br>    use_existing = bool<br>    name         = string<br>    ntp_servers  = optional(list(string))<br>    dns_servers  = optional(list(string))<br>    timezone     = optional(string)<br>    domain_name  = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(map(string))` | `[]` | no |
| <a name="input_tr_policy"></a> [tr\_policy](#input\_tr\_policy) | n/a | <pre>object({<br>    use_existing        = bool<br>    create_new          = bool<br>    name                = optional(string)<br>    root_ca_registries  = optional(list(string))<br>    unsigned_registries = optional(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_versionPolicy"></a> [versionPolicy](#input\_versionPolicy) | n/a | <pre>object({<br>    useExisting    = bool<br>    policyName     = string<br>    iksVersionName = optional(string)<br>    description    = optional(string)<br>    versionName    = optional(string)<br>  })</pre> | n/a | yes |

## BayInfotech Repositories

Please visit our repositories for more detail and other projects in automation and programability:

[https://github.com/bay-infotech](https://github.com/bay-infotech)


## BayInfotech website
We are working hard to bring more automation and programmability into community. Please contact us for more detail projects and solutions

[https://bay-infotech.com](https://bay-infotech.com)


