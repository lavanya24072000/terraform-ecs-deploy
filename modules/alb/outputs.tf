output "alb_arn" {
  value = aws_lb.this.arn
}
 
output "alb_dns_name" {
  value = aws_lb.this.dns_name
}
 
output "nginx_tg_arn" {
  value = aws_lb_target_group.nginx.arn
}
 
output "tomcat_tg_arn" {
  value = aws_lb_target_group.tomcat.arn
}
 
output "apache_tg_arn" {
  value = aws_lb_target_group.apache.arn
}
