output "vpc_id" {
  value = module.vpc.vpc_id
}

output "alb_dns" {
  value = module.alb.alb_dns
}

output "ecs_cluster_id" {
  value = module.ecs.ecs_cluster_id
}
