module "networking"{
  source = "./src/modules/network"

  networkname = "iac-network"
  auto_create_subnetworks = false
  subnet_name = iac-subnet
  subnet_cidr_range = "10.0.0.0/24"
  region = "us-west1"
  private_ip_google_access = false
  firewall_rule_name = "ssh-rule"
  source_ranges = ["0.0.0.0/0"]
  protocol = "tcp"
  ports = ["80"]
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
    subnetwork    = google_compute_subnetwork.iac-subnet.name
    access_config {}
    # address       = "${var.network_ip}"
  }

  metadata_startup_script = file("script.sh") 

}

# resource "google_compute_firewall" "ssh" {
#   name    = "ssh-rule"
#   network = google_compute_network.iac-network.self_link
#   # destination_ranges = [ "0.0.0.0/0" ]
#   source_ranges = [ "0.0.0.0/0" ]
#   allow {
#     protocol = "tcp"
#     ports    = ["22","80"]
#   }

#   #source_tags = ["iac-bastion"]
#   #target_tags = ["iac-ssh"]
# }