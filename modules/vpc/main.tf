# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
    ignore_changes = [name, range_name, ip_cidr_range]
}
}