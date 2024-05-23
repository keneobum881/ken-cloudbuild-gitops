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


# module "vpc" {
#   source  = "terraform-google-modules/network/google"
#   version = "3.3.0"

#   project_id   = "${var.project}"
#   network_name = "${var.env}"

#   subnets = [
#     {
#       subnet_name   = "${var.env}-subnet-01"
#       subnet_ip     = "10.${var.env == "dev" ? 10 : 20}.10.0/24"
#       subnet_region = "us-central1"
#     },
#     {
#       subnet_name   = "${var.env}-subnet-02"
#       subnet_ip     = "10.${var.env == "dev" ? 10 : 20}.11.0/24"
#       subnet_region = "us-central1"
#     },
#   ]

#   secondary_ranges = {
#     "${var.env}-subnet-01" = []
#     "${var.env}-subnet-02" = []
#   }
# }

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

  secondary_ip_range {
  range_name    = "${var.subnet_names[count.index]}-sec-range"
  ip_cidr_range = var.secondary_ip_ranges[lookup(var.subnet_names[count.index], var.secondary_ip_ranges)]
}
  dynamic "secondary_ip_range" {
    for_each = var.secondary_ip_ranges
    content {
      range_name    = "secondary-range-${secondary_ip_range.key}"
      ip_cidr_range = secondary_ip_range.value
    }
  }
}