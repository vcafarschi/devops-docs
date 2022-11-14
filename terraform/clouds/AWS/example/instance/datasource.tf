data "aws_vpc" "vcafarschi-vpc" {
  filter {
    name   = "tag:Name"
    values = ["vcafarschi-VPC"]
  }
}

data "aws_subnet" "lb-subnet-0" {
  vpc_id = data.aws_vpc.vcafarschi-vpc.id

  filter {
    name   = "tag:Name"
    values = ["vcafarschi-lb-subnet-0"]
  }
}

data "aws_subnet" "lb-subnet-1" {
  vpc_id = data.aws_vpc.vcafarschi-vpc.id

  filter {
    name   = "tag:Name"
    values = ["vcafarschi-lb-subnet-1"]
  }
}

data "aws_subnet" "pvt-subnet-0" {
  vpc_id = data.aws_vpc.vcafarschi-vpc.id

  filter {
    name   = "tag:Name"
    values = ["vcafarschi-pvt-subnet-0"]
  }
}

data "aws_subnet" "pvt-subnet-1" {
  vpc_id = data.aws_vpc.vcafarschi-vpc.id

  filter {
    name   = "tag:Name"
    values = ["vcafarschi-pvt-subnet-1"]
  }
}

data "aws_route_table" "pvt-rtb" {
  filter {
    name   = "tag:Name"
    values = ["vcafarschi-pvt-rtable"]
  }
}

data "aws_security_group" "bastion-sg-id" {
  name = "bastion-sg"
}

data "aws_s3_bucket" "s3" {
  bucket = "vcafarschi-uploads"
}


##################################
data "aws_subnet_ids" "example" {
  vpc_id = data.aws_vpc.vcafarschi-vpc.id
}

data "aws_subnet" "example" {
  for_each = data.aws_subnet_ids.example.ids
  id       = each.value
}

output "subnet_cidr_blocks" {
  value = {for key, value in data.aws_subnet.example : key => regexall("vcafarschi-pvt", "${value.tags.Name}")}
}

