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
# APPLICATION instance
################################################################################
resource "aws_instance" "py-app" {
  ami                    = "ami-0443305dabd4be2bc"
  instance_type          = "t2.micro"
  key_name               = "aws-sandbox-vcafarschi"
  vpc_security_group_ids = [aws_security_group.py-app-sg.id]
  subnet_id              = data.aws_subnet.pvt-subnet-0.id
  iam_instance_profile   = aws_iam_instance_profile.ec2profile.id

  tags = merge(
    var.default_tags,
    { "Name" = "vcafarschi-py-app" }
  )
}

################################################################################
# SG for APPLICATION
################################################################################
resource "aws_security_group" "py-app-sg" {
  name   = "app-sg"
  vpc_id = data.aws_vpc.vcafarschi-vpc.id
}

################################################################################
# INGRESS-SG-RULE for APPLICATION
################################################################################
resource "aws_security_group_rule" "ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = data.aws_security_group.bastion-sg-id.id
  security_group_id        = aws_security_group.py-app-sg.id
}

################################################################################
# INGRESS-SG-RULE for APPLICATION
################################################################################
resource "aws_security_group_rule" "app-port" {
  type                     = "ingress"
  from_port                = var.app_port
  to_port                  = var.app_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.classic-lb.id
  security_group_id        = aws_security_group.py-app-sg.id
}

################################################################################
# EGRESS-SG-RULE for APPLICATION
################################################################################
resource "aws_security_group_rule" "ssh-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.py-app-sg.id
}

################################################################################
# VPC to S3 endpoint
################################################################################
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = data.aws_vpc.vcafarschi-vpc.id
  service_name = "com.amazonaws.us-east-2.s3"
}

################################################################################
# Associate VPC to S3 in Private route table
################################################################################
resource "aws_vpc_endpoint_route_table_association" "example" {
  route_table_id  = data.aws_route_table.pvt-rtb.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}
