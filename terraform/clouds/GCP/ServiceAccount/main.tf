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

resource "google_service_account" "myaccount" {
  account_id   = "myaccount"
  display_name = "My Service Account"
  project = "sublime-command-322414"
}

resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.myaccount.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

output "sa_key" {
  value = google_service_account_key.mykey.private_key
  sensitive = true
}