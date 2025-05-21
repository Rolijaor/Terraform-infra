variable "region" {
  description = "Región AWS donde desplegar"
  type        = string
  default     = "eu-south-2"
}

variable "project_name" {
  description = "Prefijo para nombrar recursos"
  type        = string
  default     = "Migracion-ERP-AWS-Dev"
}

variable "tailscale_key" {
  description = "Clave de autenticación para Tailscale"
  type        = string
  sensitive   = true
}

variable "erp_image" {
  description = "URI de la imagen Docker del ERP en ECR"
  type        = string
}
