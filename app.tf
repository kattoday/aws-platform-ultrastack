# 1. IAM Role for ECS Tasks (The 'Identity' of the container)
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ultrastack-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# 2. The Task Definition (The Blueprint)
resource "aws_ecs_task_definition" "app" {
  family                   = "ultrastack-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name  = "web-app"
    image = "nginx:latest" # Using a standard web server for testing
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
}

# 3. The ECS Service (The Manager)
resource "aws_ecs_service" "main" {
  name            = "ultrastack-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = aws_subnet.public[*].id # We use public for now to avoid NAT costs
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "web-app"
    container_port   = 80
  }
}

