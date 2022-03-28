variable "networkname" {
  description = "VPC name"
  type        = string
  default     = ""
}

variable "auto_create_subnetworks" {
  description = "subnet creation flag"
  type        = bool
  default     = false
}

variable "subnet_name" {
  description = "subnet name"
  type        = string
  default     = ""
}

variable "subnet_cidr_range" {
  description = "subnet cidr range"
  type        = string
  default     = ""
}

variable "region" {
  description = "region"
  type        = string
  default     = ""
}

variable "private_ip_google_access" {
  description = "private ip access"
  type        = bool
  default     = false
}

variable "firewall_rule_name" {
  description = "firewall name"
  type        = string
  default     = ""
}

variable "source_ranges" {
  description = "ingress source ip"
  type        = list(string)
  default     = []
}

variable "protocol" {
  description = "protocol type"
  type        = string
  default     = ""
}

variable "ports" {
  description = "allow ports"
  type        = list(string)
  default     = []
}