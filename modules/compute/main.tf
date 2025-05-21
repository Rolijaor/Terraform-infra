resource "aws_instance" "tailscale_relay" {
  ami           = var.relay_ami
  instance_type = var.relay_instance_type
  subnet_id     = element(var.subnet_ids, 0)
  tags          = { Name = "${var.project_name}-tailscale-relay" }

  user_data = <<-EOF
              #!/bin/bash
              curl -fsSL https://tailscale.com/install.sh | sh
              tailscale up --authkey ${var.tailscale_key} --advertise-exit-node
              EOF
}

resource "aws_ecs_cluster" "erp" {
  name = "${var.project_name}-ecs-cluster"
}

resource "aws_ecs_task_definition" "erp_task" {
  family                   = "${var.project_name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_cpu
  memory                   = var.ecs_memory
  container_definitions    = jsonencode([{
    name      = "erp"
    image     = var.erp_image
    essential = true
    portMappings = [{ containerPort = 80, hostPort = 80 }]
    logConfiguration = {
      logDriver = "awslogs"
      options   = { "awslogs-group" = var.awslogs_group, "awslogs-region" = var.region, "awslogs-stream-prefix" = "erp" }
    }
  }])
}

resource "aws_ecs_service" "erp_service" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.erp.id
  task_definition = aws_ecs_task_definition.erp_task.arn
  desired_count   = var.ecs_desired_count
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = var.subnet_ids
    security_groups = var.security_group_ids
  }
}
