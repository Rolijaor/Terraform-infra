variable "project_name" {
  description = "Prefijo para nombrar recursos de almacenamiento"
  type        = string
}

variable "lifecycle_days" {
  description = "Días antes de mover objetos a Glacier"
  type        = number
  default     = 15
}

variable "client_usernames" {
  description = "Lista de usuarios configurados en Transfer Family"
  type        = list(string)
  default     = ["cliente1", "cliente2", "cliente3", "cliente4", "cliente5"]
}
