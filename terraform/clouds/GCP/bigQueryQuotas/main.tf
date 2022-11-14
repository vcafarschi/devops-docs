provider "google-beta" {
  # credentials = "${file("account.json")}"
  project     = "sublime-command-322414"
  region      = "us-central1"
}

terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "3.81.0"
    }
  }
}

## %2F stands for / (forward-slash) 
## example vlad/caf equals to vlad%2Fcaf
## URL for services
## URL for metrics

# locals {
#   consumer_quotas = { for index, quota in var.consumer_quotas : "${quota.service}-${quota.metric}" => quota }
# }

# resource "google_project" "my_project" {
#   provider   = google-beta
#   name       = "tf-test-project"
#   project_id = "quota"
#   org_id     = "123456789"
# }

# resource "google_service_usage_consumer_quota_override" "override" {
#   for_each = local.consumer_quotas
  
#   provider       = google-beta
#   project        = "${var.project}"
#   service        = "bigquery.googleapis.com"
#   metric         = "bigquery.googleapis.com%2Fquota%2Fquery%2Fusage"
#   limit          = "%2F%2Fproject"
#   override_value = "10485763"
#   force          = true
# }

