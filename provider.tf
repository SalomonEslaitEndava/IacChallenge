provider "google" {
  credentials = var.GOOGLE_CREDENTIALS
  project     = var.project # "iac-challenge"
  region      = var.region  # "us-west1"
  zone        = var.zone    # "us-west1-a"
}

provider "google-beta" {
  credentials = var.GOOGLE_CREDENTIALS
  project     = var.project # "iac-challenge"
  region      = var.region  # "us-west1"
  zone        = var.zone    # "us-west1-a"
}