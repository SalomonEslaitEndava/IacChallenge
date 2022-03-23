terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "salomon"

    workspaces {
      name = "iacChallenge"
    }
  }
}

provider "google" {
  credentials = GOOGLE_CREDENTIALS
  project     = "iac-challenge"
  region      = "us-west1"
  zone        = "us-west1-a"
}

provider "google-beta" {
  credentials = GOOGLE_CREDENTIALS
  project     = "iac-challenge"
  region      = "us-west1"
  zone        = "us-west1-a"
}

module "test-vpc-module" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 4.0.1"
  project_id   = "iac-challenge"
  network_name = "iac-vpc"
  mtu          = 1460

  subnets = [
    {
      subnet_name   = "subnet-iac"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    }
  ]
}