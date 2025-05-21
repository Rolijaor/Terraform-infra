variable "project_name" {
  description = "Prefijo para nombrar recursos de cómputo"
  type        = string
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

variable "relay_ami" {
  description = "AMI usada para el EC2 relay de Tailscale"
  type        = string
  default     = "ami-0c94855ba95c71c99"
}

variable "relay_instance_type" {
  description = "Tipo de instancia para el relay Tailscale"
  type        = string
  default     = "t3.micro"
}

variable "subnet_ids" {
  description = "IDs de las subnets privadas para ECS y relay"
  type        = list(string)
}

variable "security_group_ids" {
  description = "IDs de Security Groups para ECS y relay"
  type        = list(string)
}

variable "ecs_cpu" {
  description = "vCPU asignadas a la tarea Fargate"
  type        = number
  default     = 512
}

variable "ecs_memory" {
  description = "RAM (MB) asignada a la tarea Fargate"
  type        = number
  default     = 2048
}

variable "ecs_desired_count" {
  description = "Número inicial de réplicas ECS/Fargate"
  type        = number
  default     = 1
}

variable "awslogs_group" {
  description = "Nombre del log group de CloudWatch para ECS"
  type        = string
  default     = "/ecs/erp"
}

variable "region" {
  description = "Región AWS donde se desplegará el clúster ECS"
  type        = string
}
