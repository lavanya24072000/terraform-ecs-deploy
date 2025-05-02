module "vpc" {
  source               = "../modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  azs                  = var.azs
}

module "alb" {
  source            = "../modules/alb"
  alb_name          = "${var.env}-alb"
  subnet_ids = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
   security_group_id = var.alb_sg_id
}
 
module "ecs" {
  source            = "../modules/ecs"
  cluster_id        = module.ecs_cluster.id
  subnet_ids = module.vpc.public_subnet_ids
  security_group_id = var.alb_sg_id
  nginx_tg_arn      = module.alb.nginx_tg_arn
  tomcat_tg_arn     = module.alb.tomcat_tg_arn
  apache_tg_arn     = module.alb.apache_tg_arn
  env               = var.env
}
