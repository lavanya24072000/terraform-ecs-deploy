variables.tf (ECS)
variable "cluster_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_id" {}
variable "nginx_tg_arn" {}
variable "tomcat_tg_arn"{}
variable "apache_tg_arn"{}