resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public" {
  count = 3
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = true
}
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "main-vpc"
  }
}
 
resource "aws_internet_gateway" "gw" {
vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}
 

 
 
resource "aws_route_table" "public" {
vpc_id = aws_vpc.main.id
 
  route {
    cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.gw.id
  }
 
  tags = {
    Name = "public-rt"
  }
}
 
resource "aws_route_table_association" "public" {
  count          =  3
  subnet_id      = aws_subnet.public[count.index].id
route_table_id = aws_route_table.public.id
}
