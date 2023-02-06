terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("terraform-377022-7e0c04d348e8.json")

  project = "terraform-377022"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name = "terraform-instance"
  machine_type = "f1-micro"
  tags = ["test", "terraform", "gcp"]

  boot_disk {
        initialize_params {
                image = "cos-cloud/cos-stable"
        }
  }

  network_interface {
        network = google_compute_network.vpc_network.name
        access_config {
        }
  }

}
