# 1. The ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "ultrastack-cluster"
}

# 2. The Application Load Balancer (ALB)
resource "aws_lb" "main" {
  name               = "ultrastack-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public[*].id
}

# 3. The ALB Target Group (Where traffic goes)
resource "aws_lb_target_group" "app" {
  name        = "ultrastack-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path = "/"
  }
}

# 4. The ALB Listener (Connects Port 80 to the Target Group)
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

