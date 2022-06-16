################################################
# for_each with a LIST
################################################
variable "customer_cidrs_list" {
  type = list(string)
  default = [
    "89.149.124.110/32", "89.149.124.111/32",
    "89.149.124.112/32"
  ]
}

resource "aws_security_group" "customer_sg" {
  name   = "customer_sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.customer_cidrs_list
    content {
      from_port   = 8443
      to_port     = 8443
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_cidr_block]
  }
  tags = { Name = "customer_sg" }
}

################################################
# for_each with a MAP
################################################
variable "customer_cidrs_map" {
  type = map(string)
  default = {
    "89.149.124.110/32" = "8443",
    "89.149.124.111/32" = "8555",
    "89.149.124.112/32" = "8663"
  }
}

resource "aws_security_group" "customer_sg" {
  name   = "customer_sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.customer_cidrs_map
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [ingress.key]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_cidr_block]
  }
  tags = { Name = "customer_sg" }
}

################################################
# for_each with a LIST of OBJECTS
################################################
variable "sg_list" {
  type = list(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = [
    {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["10.0.1.0/24"]
    },
    {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["10.0.2.0/24"]
    }
  ]
}

resource "aws_security_group" "ssh_http" {
  name   = "ssh_http"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_list
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}
