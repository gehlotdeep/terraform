# -----------------------------
# EBS Volume Size Variable
# -----------------------------
variable "volume_ebs" {
  description = "Elastic Block Storage size (in GB)"
  type        = number
  default     = 8
}

# -----------------------------
# VPC Name Variable
# -----------------------------
variable "my_vpc" {
  description = "Name of the VPC"
  type        = string
}

# -----------------------------
# Security Group Name Variable
# -----------------------------
variable "my_security_group" {
  description = "Name of the security group"
  type        = string
  default     = "my-security-group"
}

# ----------------------------
# Variable Volume EBS
# ----------------------------
variable "env" {
  type    = string
  default = "dev"
}
# ----------------------------
# Instance Type
# ----------------------------
variable "instance_type" {
  description = "Name of instance size"
  default     = "t3.medium"
  type        = string
}
