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

resource "google_service_account" "github_actions" {
  account_id   = "github-actions-ci"
  display_name = "GitHub Actions CI Service Account"
  description  = "Service account used by GitHub Actions to run CI validation"
}

resource "google_project_iam_member" "github_actions_bigquery_job_user" {
  project = var.project_id
  role    = "roles/bigquery.jobUser"
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_project_iam_member" "github_actions_bigquery_data_editor" {
  project = var.project_id
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}