##############################################################################
##               CLUSTER ( CONTROL PLANE)                                   ##
##############################################################################

resource "google_container_cluster" "primary" {
  name     = local.cluster_name
  location = var.region
  project  = local.project_id
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  initial_node_count       = 1
  remove_default_node_pool = true
  networking_mode = "VPC_NATIVE"  ## Needed for Container Native Ingress
  network    = var.network
  subnetwork = var.sub_network
  ip_allocation_policy {
    cluster_ipv4_cidr_block = null
    services_ipv4_cidr_block = null
  }
}

##############################################################################
##               WORKER NODES                                               ##
##############################################################################

resource "google_container_node_pool" "primary_nodes" {
  name       = "worker-group"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = merge(local.common_labels, {
      CLUSTER = "${local.cluster_name}-worker"
    })

    machine_type = var.machine_type
    tags         = ["${local.cluster_name}-worker"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}