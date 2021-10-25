# Incase if the downloaded credentials file is `xyz.json` , 
# The credentials value should be "xyz", dont add .json .
# Please dont forget to add json file in root of this project 
credentials = "XXXXXXXX"
# The name of the cluster (string) 
cluster_name = "XXXXXXXX"
# the project ID with GKE API enabled (string)
project_id  = "XXXXXXXXX"
# The helm configs , The Ingress value can be of any type (node-port, container-native). 
helm_conf   =  {
      airflow   = {
      name    = "airflow"
      repo    = "https://airflow.apache.org"
      chart   = "airflow"
      namespace = "airflow"
      ingress  = "container-native"
    }
  }
