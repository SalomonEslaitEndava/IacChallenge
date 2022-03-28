variable "instance_count" {
  description = "instace count"
  type        = number
  default     = 0
}

variable "instance_name" {
  description = "instance name"
  type        = string
  default     = ""
}

variable "instance_zone" {
  description = "instance zone"
  type        = string
  default     = ""
}

variable "machine_type" {
  description = "machine type"
  type        = string
  default     = ""
}

variable "allow_stopping_for_update" {
  description = "stopping for update"
  type        = bool
  default     = true
}

variable "instance_image" {
  description = "instance image"
  type        = string
  default     = ""
}
