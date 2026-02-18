variable "env" {
  description = "This is my module dev infra-app"
  type        = string
}

variable "bucket_name" {
  description = "This is my module bucket dev infra-app"
  type        = string
}

variable "instance_count" {
  description = "This is no. of instance count of dev infra-app"
  type        = number
}

variable "instance_type" {
  description = "This is instance type of dev infra-app"
  type        = string
}

variable "ec2_ami_id" {
  description = "This is dev ami infra-app"
  type        = string
}

variable "hash_key" {
  description = "This is hash key infra-app"
  type        = string
}

variable "dynamodb_table" {
  description = "This is hash key infra-app"
  type        = string
}
