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
