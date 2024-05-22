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
  env = "dev"
}

provider "google" {
  project = "${var.project}"
}

module "vpc" {
  source  = "../../modules/vpc"
  project = "${var.project}"
  env     = "${local.env}"
}

resource "google_container_cluster" "learning" {
  name     = "ken-gke-cluster"
  location = "us-west1"
  network = "dev"
  subnetwork = "dev-subnet-01"
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "learning_preemptible_nodes" {
  name       = "ken-node-pool"
  location   = "us-west1"
  cluster    = google_container_cluster.learning.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-micro"
    service_account = "id-420039265868-ken@aksgkelearning.iam.gserviceaccount.com"
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
