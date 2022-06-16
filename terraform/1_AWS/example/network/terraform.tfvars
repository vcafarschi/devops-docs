default_tags = {
  Owner      = "vcafarschi"
  Discipline = "AM"
  Purpose    = "Learning"
}

my_ip = "89.149.124.110/32"

bastion_cidr = "10.0.1.240/28"

azs =["us-east-2a","us-east-2b"]
lb-pub-subnets =["10.0.2.240/28", "10.0.3.240/28"]
app-pvt-subnets = ["10.0.4.0/24", "10.0.5.0/24"]
