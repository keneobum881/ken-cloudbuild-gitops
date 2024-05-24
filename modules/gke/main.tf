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


locals {
  network = "${var.env}"
  subnet  = "${var.subnet_names[1]}"
}

# resource "google_container_cluster" "learning" {
#   name     = "${var.gke_name}"
#   location = "${var.region}"
#   network = "${local.network}"
#   subnetwork = "${local.subnet}"
#   remove_default_node_pool = true
#   initial_node_count       = 1
# }

# resource "google_container_node_pool" "learning_preemptible_nodes" {
#   name       = "${var.gke_name}-node-pool"
#   location   = "${var.region}"
#   cluster    = google_container_cluster.learning.name
#   node_count = 1

#   node_config {
#     preemptible  = true
#     machine_type = "e2-micro"
#     service_account = "id-420039265868-ken@aksgkelearning.iam.gserviceaccount.com"
#     oauth_scopes    = [
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]
#   }
# }
