
terraform {
  source = "git::git@github.com:foo/modules.git//app?ref=v0.0.3"
}

include "root" {
  path = find_in_parent_folders()
}

