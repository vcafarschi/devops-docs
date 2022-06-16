################################################
# for_each with a LIST
################################################
variable "user_names0" {
  type    = list(string)
  default = ["vlad", "constantin", "egor"]
}

resource "aws_iam_user" "example" {
  for_each = toset(var.user_names0)
  name     = each.value
}

################################################
# for_each with a SET
################################################
variable "user_names1" {
  type    = set(string)
  default = ["vlad", "constantin", "egor"]
}

resource "aws_iam_user" "example" {
  for_each = var.user_names1
  name     = each.value
}

################################################
# for_each with a MAP
################################################
variable "subnets_map" {
  type = map(string)
  default = {
    us-east-1a = "10.0.1.0/24"
    us-east-1b = "10.0.2.0/24"
    us-east-1c = "10.0.3.0/24"
  }
}

resource "aws_subnet" "example" {
  for_each = var.subnets_map

  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = each.key
}

################################################
# for_each with a MAP of OBJECTS
################################################
variable "instances_map" {
  type = map(object({
    ami                 = string
    instance_type       = string
    associate_public_ip = bool
  }))

  default = {
    artifactory = {
      ami                 = "ami-0e2b68f7b98b92c69"
      instance_type       = "t3.small"
      associate_public_ip = false
    },
    jenkins = {
      ami                 = "ami-0e2b68f7b98b92c69"
      instance_type       = "t3.small"
      associate_public_ip = true
    }

  }
}

resource "aws_instance" "this" {
  for_each = var.instances_map

  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  associate_public_ip_address = each.value.associate_public_ip
  tags                        = { Name = each.key }
}

################################################
# for_each with a LIST of OBJECTS
################################################
variable "instances_list_of_objects" {
  type = list(object({
    ami                 = string
    instance_type       = string
    associate_public_ip = bool
  }))

  default = [
    {
      name                = "artifactory"
      ami                 = "ami-0e2b68f7b98b92c69"
      instance_type       = "t3.small"
      associate_public_ip = false
    },
    {
      name                = "jenkins"
      ami                 = "ami-0e2b68f7b98b92c69"
      instance_type       = "t3.small"
      associate_public_ip = true
    }
  ]
}

resource "aws_instance" "this" {
  for_each                    = { for vm in var.instances_list_of_objects : vm.name => vm } ## Transforms list of objects in map of objects

  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  associate_public_ip_address = each.value.associate_public_ip
  tags                        = { Name = each.value.name }
}
