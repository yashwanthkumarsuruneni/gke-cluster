##############################################################################
## DEPLOYMENTS
##############################################################################

provider "helm" {
  kubernetes {
    host                    = "https://${google_container_cluster.primary.endpoint}"
    # client_certificate    = base64decode(google_container_cluster.primary.master_auth[0].client_certificate)
    # client_key            = base64decode(google_container_cluster.primary.master_auth[0].client_key)
    token                   = data.google_client_config.provider.access_token
    cluster_ca_certificate  = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  }
}


resource "helm_release" "apache_airflow" {
  name              = var.helm_conf.airflow.name
  repository        = var.helm_conf.airflow.repo
  chart             = var.helm_conf.airflow.chart
  namespace         = var.helm_conf.airflow.namespace
  create_namespace  = true
  cleanup_on_fail   = true
  wait              = false  ## ISSUE: 15340 (https://github.com/apache/airflow/issues/15340)
  dependency_update = true

  values            = [ 
      file("${path.root}/deployments/airflow/${var.helm_conf.airflow.ingress}.yaml")
  ]

  depends_on        = [
    google_container_cluster.primary,
    google_container_node_pool.primary_nodes
  ]
}