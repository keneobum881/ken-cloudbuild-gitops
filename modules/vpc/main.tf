resource "google_compute_network" "ken_network" {
  project                 = "${var.project}"
  name                    = "${var.env}"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "ken_subnetwork" {
  count = length(var.subnet_names)
  name          = var.subnet_names[count.index]
  ip_cidr_range = var.ip_cidr_ranges[count.index]
  region        = var.region
  network       = google_compute_network.ken_network.id
  project       = var.project

  dynamic "secondary_ip_range" {
    for_each = var.secondary_ip_ranges["ken-subnet-${count.index + 1}"]
    content {
      range_name    = "secondary-range-${secondary_ip_range.key}"
      ip_cidr_range = "${secondary_ip_range.value}"
    }
  }
  lifecycle {
    ignore_changes = [name, ip_cidr_range]
}
}