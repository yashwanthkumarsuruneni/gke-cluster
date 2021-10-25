##############################################################################
## VARIABLES
##############################################################################

variable "region" {
  description = "Region you would like to provision resources"
  type        = string
  default     = "us-east1"
}

variable "credentials" {
  description = "The credentials to create the infrastructure"
  type        = string
}

variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
}

variable "project_id" {
  description = "The project id where the cluster is created"
  type        = string
  default     = null
}

variable "machine_type" {
  description = "The name of a Google Compute Engine machine type"
  type        = string
  default     = "e2-medium"
}

variable "network" {
  description = "The VPC network where the cluster has to be created"
  type        = string
  default     = "default"
}

variable "sub_network" {
  description = "The VPC sub network where the cluster has to be created"
  type        = string
  default     = "default"
}

variable "helm_conf" {
  description   = "Airflow deployment details"
  type          = map(map(string))
  default       = {
    airflow     = {
      name      = "airflow"
      repo      = "https://airflow.apache.org"
      chart     = "airflow"
      namespace = "airflow"
      ingress   = "container-native"
    }
  }
}


