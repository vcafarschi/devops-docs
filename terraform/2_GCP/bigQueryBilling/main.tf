provider "google" {
  # credentials = "${file("~/sublime-command-322414-aad6ea456f46.json")}"
  project     = "sublime-command-322414"
  billing_project = "sublime-command-322414"
  user_project_override = true
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

# resource "google_billing_budget" "budget" {
#   # billing_account = data.google_billing_account.account.id
#   billing_account = "01360D-8E24B0-8B2AA7"
#   display_name    = "Example Billing Budget"

#   budget_filter {
#     # projects = ["projects/${data.google_project.project.number}"]
#     projects = ["projects/sublime-command-322414"]
#     services = ["services/24E6-581D-38E5"]
#   }

#   amount {
#     specified_amount {
#       currency_code = "USD"
#       units         = "1000"
#     }
#   }

#   threshold_rules {
#     threshold_percent = 0.5
#   }
#     threshold_rules {
#     threshold_percent = 0.9
#   }
#     threshold_rules {
#     threshold_percent = 1.0
#   }

#   threshold_rules {
#     threshold_percent = 1.0
#     spend_basis       = "FORECASTED_SPEND"
#   }

#   all_updates_rule {
#     monitoring_notification_channels = [
#       google_monitoring_notification_channel.notification_channel.id,
#     ]
#     disable_default_iam_recipients = true
#   }
# }

# resource "google_monitoring_notification_channel" "notification_channel" {
#   display_name = "vladislav.cafarschi"
#   type         = "email"

#   labels = {
#     email_address = "vladislav.cafarschi@gmail.com"
#   }
# }

data "google_container_engine_versions" "engine_version" {
  location = "europe-west1"
}

output "name" {
  value = data.google_container_engine_versions.engine_version
}
