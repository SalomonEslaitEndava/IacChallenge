resource "google_compute_instance" "default" {
  count = var.instance_count # 1
  name  = var.instance_name #"iac-vm"
  zone  = var.instance_zone# "us-west1-a"
  # tags                      = ["${concat(list("${var.name}-ssh", "${var.name}"), var.node_tags)}"]
  machine_type = var.machine_type #"f1-micro"
  # min_cpu_platform          = "${var.min_cpu_platform}"
  allow_stopping_for_update = var.allow_stopping_for_update# true

  boot_disk {
    #auto_delete = "${var.disk_auto_delete}"

    initialize_params {
      image = var.instance_image #"centos-cloud/centos-7"
      #size  = "${var.disk_size_gb}"
      #type  = "${var.disk_type}"
    }
  }

  network_interface {
    subnetwork = "iac-subnet" #google_compute_subnetwork.iac-subnet.name
    access_config {}
    # address       = "${var.network_ip}"
  }

  metadata_startup_script = file("script.sh")

}