terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "salomon"

    workspaces {
      name = "iacChallenge"
    }
  }
}

provider "google" {
  credentials = var.GOOGLE_CREDENTIALS
  project     = "iac-challenge"
  region      = "us-west1"
  zone        = "us-west1-a"
}

provider "google-beta" {
  credentials = var.GOOGLE_CREDENTIALS
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

resource "google_compute_instance" "vm_instance" {
  name         = "vm-iac"
  machine_type = "n1-standart-2"
  zone         = "us-west1-a"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  network_interface {
    network = "iac-vpc"

    access_config {
      // Ephemeral IP
    }
  }
}