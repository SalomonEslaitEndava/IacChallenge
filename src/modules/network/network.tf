resource "google_compute_network" "iac-network" {
  name                    = var.networkname
  auto_create_subnetworks = var.auto_create_subnetworks
}

resource "google_compute_subnetwork" "iac-subnet" {
  name                     = var.subnet_name
  ip_cidr_range            = var.subnet_cidr_range
  network                  = google_compute_network.iac-network.self_link
  region                   = var.region
  private_ip_google_access = var.private_ip_google_access
}

resource "google_compute_firewall" "ssh" {
  name          = var.firewall_rule_name
  network       = google_compute_network.iac-network.self_link
  source_ranges = var.source_ranges
  allow {
    protocol = var.protocol
    ports    = var.ports
  }
}