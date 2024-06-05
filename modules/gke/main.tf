locals {
  network = "${var.env}"
  subnet  = "${var.subnet_names[1]}"
}

resource "google_container_cluster" "learning" {
  name     = "${var.gke_name}"
  location = "${var.region}"
  network = "${local.network}"
  subnetwork = "${local.subnet}"
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection = false
}

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
