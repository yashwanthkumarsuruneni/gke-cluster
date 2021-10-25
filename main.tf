##################################################################################
##       PROJECT                                  
##################################################################################


locals {
   cluster_name  = terraform.workspace == "default" ?  var.cluster_name : "${terraform.workspace}-${var.cluster_name}"
   project_id    = var.project_id 
   common_labels = {
     ENVIRONMENT = terraform.workspace
     REGION      = var.region
     OWNED_BY    = "MARVEL_TEAM"
     PROJECT     = local.project_id
   }
}
