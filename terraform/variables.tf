variable "vpc_cidr" {}
variable "public_subnet_cidrs" { type = list(string) }
variable "azs" { type = list(string) }
variable "alb_name" {}
variable "alb_sg_id" {}
variable "cluster_name" {}


  