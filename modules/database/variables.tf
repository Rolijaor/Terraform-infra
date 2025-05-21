variable "project_name" {
  type = string
}

variable "aurora_instance_class" {
  type    = string
  default = "db.t3.small"
}

variable "aurora_instances" {
  type    = number
  default = 2
}

variable "aurora_backup_retention_days" {
  type    = number
  default = 15
}

variable "redshift_node_type" {
  type    = string
  default = "dc2.large"
}

variable "redshift_node_count" {
  type    = number
  default = 2
}

variable "redshift_master_user" {
  type = string
}

variable "redshift_master_password" {
  type      = string
  sensitive = true
}
