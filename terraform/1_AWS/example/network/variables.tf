variable "default_tags" {
  type = map(string)
}

variable "my_ip" {
  type = string
}

variable "bastion_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "lb-pub-subnets" {
  type = list(string)
}

variable "app-pvt-subnets" {
  type = list(string)
}
