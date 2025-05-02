resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = var.security_group_id
}
 
# Target Group: Nginx
resource "aws_lb_target_group" "nginx" {
  name        = "${var.env}-nginx-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}
 
# Target Group: Tomcat
resource "aws_lb_target_group" "tomcat" {
  name        = "${var.env}-tomcat-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}
 
# Target Group: Apache
resource "aws_lb_target_group" "apache" {
  name        = "${var.env}-apache-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}
 
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404 Not Found"
      status_code  = "404"
    }
  }
}
 
# Listener Rule: Nginx
resource "aws_lb_listener_rule" "nginx" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }
  condition {
    path_pattern {
      values = ["/nginx/*"]
    }
  }
}
 
# Listener Rule: Tomcat
resource "aws_lb_listener_rule" "tomcat" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 200
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tomcat.arn
  }
  condition {
    path_pattern {
      values = ["/tomcat/*"]
    }
  }
}
 
# Listener Rule: Apache
resource "aws_lb_listener_rule" "apache" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 300
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apache.arn
  }
  condition {
    path_pattern {
      values = ["/apache/*"]
    }
  }
}