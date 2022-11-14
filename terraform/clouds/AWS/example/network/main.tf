provider "aws" {
  profile                 = "endava"
  shared_credentials_file = "/home/vcafarschi/.aws/credentials"
  region                  = "us-east-2"
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.49"
    }
  }
}

################################################################################
# Create VPC
################################################################################
resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = merge(
    var.default_tags,
    { "Name" = "vcafarschi-VPC" }
  )
}

################################################################################
# Create IGW
################################################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.default_tags,
    { "Name" = "vcafarschi-IGW" }
  )
}

################################################################################
# Create BASTION PUBLIC subnet
################################################################################
resource "aws_subnet" "bastion-subnet" {
  cidr_block              = var.bastion_cidr
  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = true

  tags = merge(
    var.default_tags,
    { "Name" = "vcafarschi-bastion-subnet" }
  )
}

################################################################################
# Create LB only PUBLIC subnets
################################################################################
resource "aws_subnet" "pub-subnet" {
  count = length(var.lb-pub-subnets)

  cidr_block              = element(var.lb-pub-subnets, count.index)
  availability_zone       = element(var.azs, count.index)
  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = true

  tags = merge(
    var.default_tags,
    { "Name" = "vcafarschi-lb-subnet-${count.index}" }
  )
}

################################################################################
# Create PRIVATE subnets
################################################################################
resource "aws_subnet" "pvt-subnet" {
  count = length(var.app-pvt-subnets)

  cidr_block              = element(var.app-pvt-subnets, count.index)
  availability_zone       = element(var.azs, count.index)
  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = false

  tags = merge(
    var.default_tags,
    { "Name" = "vcafarschi-pvt-subnet-${count.index}" }
  )
}

################################################################################
# Create RT for public subnets and BASTION
################################################################################
resource "aws_route_table" "pub-route-table" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.default_tags,
    { "Name" = "vcafarschi-pub-rtable" }
  )
}

################################################################################
# Create Route Table for PRIVATE Subnets
################################################################################
resource "aws_route_table" "pvt-route-table" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.default_tags,
    { "Name" = "vcafarschi-pvt-rtable" }
  )
}

################################################################################
# Create Route Table association for Bastion subnet
################################################################################
resource "aws_route_table_association" "bastion-assoc" {
  subnet_id      = aws_subnet.bastion-subnet.id
  route_table_id = aws_route_table.pub-route-table.id
}

################################################################################
# Create Route Table association for PUBLIC subnets
################################################################################
resource "aws_route_table_association" "public-assoc" {
  count = length(var.lb-pub-subnets)

  subnet_id      = element(aws_subnet.pub-subnet.*.id, count.index)
  route_table_id = aws_route_table.pub-route-table.id
}

################################################################################
# Create Route Table association for PRIVATE subnets
################################################################################
resource "aws_route_table_association" "private-assoc" {
  count = length(var.app-pvt-subnets)

  subnet_id      = element(aws_subnet.pvt-subnet.*.id, count.index)
  route_table_id = aws_route_table.pvt-route-table.id
}

################################################################################
# Create PUBLIC Route Table Rules
################################################################################
resource "aws_route" "pub-rt-route" {
  route_table_id = aws_route_table.pub-route-table.id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
