module "networking" {
  source = "./src/modules/network"

  networkname              = "iac-network"
  auto_create_subnetworks  = false
  subnet_name              = "iac-subnet"
  subnet_cidr_range        = "10.0.0.0/24"
  region                   = "us-west1"
  private_ip_google_access = false
  firewall_rule_name       = "ssh-rule"
  source_ranges            = ["0.0.0.0/0"]
  protocol                 = "tcp"
  ports                    = ["80"]
}

module "compute_engine"{
  source = "./src/modules/compute_engine"

  count = 1
  name = "iac-vm"
  zone = "us-west1-a"
  machine_type = "f1-micro"
  allow_stopping_for_update = true
  image = "centos-cloud/centos-7"
}