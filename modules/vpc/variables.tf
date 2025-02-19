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

variable "env" {
  description = "The environment where the subnetworks will be created."
  default     = "dev"
}

variable "project" {
  description = "The ID of the project where the subnetworks will be created."
}

variable "region" {
  description = "The region where the subnetworks will be created."
  default     = "us-central1"
}

variable "subnet_names" {
  description = "A list of names for the subnetworks."
  default     = ["ken-subnet-1", "ken-subnet-2", "ken-subnet-3", "ken-subnet-4"]
}

variable "ip_cidr_ranges" {
  description = "A list of IP CIDR ranges for the subnetworks."
  default     = ["10.10.0.0/24", "10.11.0.0/24", "10.12.0.0/24", "10.13.0.0/24"]
}

variable "secondary_ip_ranges" {
  description = "A map of secondary IP ranges for the subnetworks."
  default = {
    ken-subnet-1 = ["10.10.1.0/24", "10.10.2.0/24"]
    ken-subnet-2 = ["10.11.1.0/24", "10.11.2.0/24"]
    ken-subnet-3 = ["10.12.1.0/24", "10.12.2.0/24"]
    ken-subnet-4 = ["10.13.1.0/24", "10.13.2.0/24"]
  }
}