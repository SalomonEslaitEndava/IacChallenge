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

resource "google_compute_network" "iac-network" {
  name                    = "iac-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "iac-subnet" {
  name                     = "iac-subnet"
  ip_cidr_range            = "10.0.0.0/24"
  network                  = google_compute_network.iac-network.self_link
  region                   = "us-west1"
  private_ip_google_access = true
}

resource "google_compute_instance" "default" {
  count                     = 1
  name                      = "iac-vm"
  zone                      = "us-west1-a"
  # tags                      = ["${concat(list("${var.name}-ssh", "${var.name}"), var.node_tags)}"]
  machine_type              = "f1-micro"
  # min_cpu_platform          = "${var.min_cpu_platform}"
  allow_stopping_for_update = true

  boot_disk {
    #auto_delete = "${var.disk_auto_delete}"

    initialize_params {
      image = "centos-cloud/centos-7"
      #size  = "${var.disk_size_gb}"
      #type  = "${var.disk_type}"
    }
  }

  network_interface {
    subnetwork    = google_compute_subnetwork.subnet.name
    access_config = {}
    # address       = "${var.network_ip}"
  }

}

resource "google_compute_firewall" "ssh" {
  name    = "ssh-rule"
  network = google_compute_subnetwork.subnet.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  #source_tags = ["${var.name}-bastion"]
  #target_tags = ["${var.name}-ssh"]
}