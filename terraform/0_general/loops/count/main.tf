
resource "aws_iam_user" "example" {
  count = 3
  name  = "neo.${count.index}"
}


variable "users_list" {
  type    = list(string)
  default = ["vlad", "constantin", "egor"]
}

resource "aws_iam_user" "example" {
  count = length(var.users_list)
  name  = var.users_list[count.index]
}
