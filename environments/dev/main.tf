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

# module "gke_cluster" {
#   source  = "../../modules/gke"
#   project = "${var.project}"
# }