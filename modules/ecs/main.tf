resource "aws_ecs_cluster" "this" {
  name = var.cluster_id
}

resource "aws_ecs_task_definition" "nginx" {
  family                   = "nginx-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx:latest"
      essential = true
      portMappings = [{ containerPort = 80 }]
    }
  ])
}
resource "aws_ecs_task_definition" "tomcat" {
  family                   = "nginx-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx:latest"
      essential = true
      portMappings = [{ containerPort = 80 }]
    }
  ])
}
resource "aws_ecs_task_definition" "apache" {
  family                   = "nginx-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx:latest"
      essential = true
      portMappings = [{ containerPort = 80 }]
    }
  ])
}


resource "aws_ecs_service" "nginx" {
  name            = "${var.env}-nginx-service"
  cluster         = var.cluster_id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = 1
 
  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [var.security_group_id]
    assign_public_ip = true
  }
 
  load_balancer {
    target_group_arn = var.nginx_tg_arn
    container_name   = "nginx"
    container_port   = 80
  }
}
 
# Same for Tomcat
resource "aws_ecs_service" "tomcat" {
  name            = "${var.env}-tomcat-service"
  cluster         = var.cluster_id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.tomcat.arn
  desired_count   = 1
 
  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [var.security_group_id]
    assign_public_ip = true
  }
 
  load_balancer {
    target_group_arn = var.tomcat_tg_arn
    container_name   = "tomcat"
    container_port   = 8080
  }
}
 
# Same for Apache
resource "aws_ecs_service" "apache" {
  name            = "${var.env}-apache-service"
  cluster         = var.cluster_id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.apache.arn
  desired_count   = 1
 
  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [var.security_group_id]
    assign_public_ip = true
  }
 
  load_balancer {
    target_group_arn = var.apache_tg_arn
    container_name   = "apache"
    container_port   = 80
  }
}
