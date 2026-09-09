terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.6.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_bigquery_dataset" "raw" {
  dataset_id = "retail_raw"
  location   = var.region

  description = "Raw data layer for the retail sales analytics platform"
}

resource "google_storage_bucket" "raw" {
  name     = "${var.project_id}-raw-data"
  location = var.region

  uniform_bucket_level_access = true

  force_destroy = true
}