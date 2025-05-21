variable "project_name" {
  type        = string
  description = "Prefijo para nombrar recursos de red"
}

variable "cidr_block" {
  type        = string
  description = "Rango CIDR de la VPC"
}

variable "private_cidrs" {
  type        = map(string)
  description = "Mapeo AZ → CIDR para subnets privadas"
}

variable "az_with_nat" {
  type        = string
  description = "Clave del mapa private_cidrs donde colocar el NAT Gateway"
}
