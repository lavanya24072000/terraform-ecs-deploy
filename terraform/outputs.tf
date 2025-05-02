output "vpc_id" {
  value = modules.vpc.vpc_id
}

output "alb_dns" {
  value = modules.alb.alb_dns
}

output "ecs_cluster_id" {
  value = modules.ecs.ecs_cluster_id
}
