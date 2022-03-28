resource "google_compute_network" "iac-network" {
  name                    = var.networkname #"iac-network"
  auto_create_subnetworks = var.auto_create_subnetworks # false
}

resource "google_compute_subnetwork" "iac-subnet" {
  name                     = var.subnet_name #"iac-subnet"
  ip_cidr_range            = var.subnet_cidr_range #"10.0.0.0/24"
  network                  = google_compute_network.iac-network.self_link
  region                   = var.region #"us-west1"
  private_ip_google_access = var.private_ip_google_access # false
}

resource "google_compute_firewall" "ssh" {
  name    = var.firewall_rule_name # "ssh-rule"
  network = google_compute_network.iac-network.self_link
  # destination_ranges = [ "0.0.0.0/0" ]
  source_ranges = var.source_ranges #[ "0.0.0.0/0" ]
  allow {
    protocol = var.protocol #"tcp"
    ports    = var.ports #["80"]
  }

  #source_tags = ["iac-bastion"]
  #target_tags = ["iac-ssh"] 
}