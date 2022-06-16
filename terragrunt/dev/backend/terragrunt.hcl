
terraform {
  source = "git::git@github.com:foo/modules.git//app?ref=v0.0.3"
}

include "root" {
  path = find_in_parent_folders()
}


dependency "vpc" {
  config_path = "../vpc"
}

dependency "mysql" {
  config_path = "../mysql"
}

# Indicate the input values to use for the variables of the module.
inputs = {

}