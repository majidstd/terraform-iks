variable "intersight_apikey" {
  type        = string
  description = "API Key"
}
variable "intersight_secretkey" {
  type        = string
  description = "Secret Key or file location"
}
variable "intersight_endpoint" {
  type        = string
  description = "API Endpoint URL"
  default     = "https://www.intersight.com"
}
variable "organization" {
  type        = string
  description = "Organization Name"
  default     = "default"
}
variable "iks_ssh_user" {
  type        = string
  description = "SSH Username for node login."
  default     = "iksadmin"
}
variable "iks_ssh_key" {
  type        = string
  description = "SSH Public Key to be used to node login."
}
variable "tags" {
  type    = list(map(string))
  default = []
}
variable "vcPassword" {
  sensitive   = true
  type        = string
  description = "Password of the account to be used with vCenter.  This should be the password for the account used to register vCenter with Intersight."
  default     = null
}