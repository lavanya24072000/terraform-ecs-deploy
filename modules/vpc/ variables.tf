variable "vpc_cidr" {
  type = sting
}
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}

