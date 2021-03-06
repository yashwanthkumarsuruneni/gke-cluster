# GKE cluster 
  A simple GKE cluster in default VPC Network. 

**Prerequisites**
*  Docker installed in your machine
*  A GCP account and a project in it with GKE API Enabled
*  A service Account (JSON KEY) with full ownership permissions to create a GKE Cluster.

## Inputs 

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="credentials"></a> [credentials](#input\_credentials) | Service Account Cred (Exclude extension .json)  | `string` | none | yes |
| <a name="cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster Name | `string` | none | yes |
| <a name="project_id"></a> [project\_id](#input\_project\_id) | The project Id with GKE API Enabled | `string` | none | yes |
| <a name="region"></a> [region](#input\_region) | GCP region where you would like to provision | `string` | us-east1 | no |
| <a name="machine_type"></a> [machine\_type](#input\_machine\_type) | The Compute Machine Type| `string` | e2-medium | no |
| <a name="network"></a> [network](#input\_network) | The name of the VPC network | `string` | default | no |
| <a name="sub_network"></a> [sub\_network](#input\_sub\_network) | The name of the subnet | `string` | default | no |
| <a name="helm_conf"></a> [helm\_conf](#input\_helm\_conf) | The configs for the helm charts to be deployed  | `map(map(string))` | { airflow = { name = "airflow" ,repo = "https://airflow.apache.org" , chart = "airflow", namespace = "airflow" ,ingress  = "container-native" } } | no |

## Instructions 

### Step-1 (Deploy)

- Please download the key file for the service account (in JSON format) which you would like to use and add it in the root folder.
- Fill the placeholders in `env/lab.tfvars`.

```bash
docker run -i -t -v $PWD:$PWD -w $PWD hashicorp/terraform:0.14.11 init
docker run -i -t -v $PWD:$PWD -w $PWD hashicorp/terraform:0.14.11 workspace new lab
docker run -i -t -v $PWD:$PWD -w $PWD hashicorp/terraform:0.14.11 plan --var-file=./env/lab.tfvars -out lab.tfplan
docker run -i -t -v $PWD:$PWD -w $PWD hashicorp/terraform:0.14.11 apply "lab.tfplan"
 ```

### Step-2 (Validate)
- Once the cluster is created , Login into the GCP console , please wait untill the IP's are attached to the Ingresses. Intially you may see 404, please wait for 5 mins.    
### Step-3 (Destroy)

```bash
docker run -i -t -v $PWD:$PWD -w $PWD hashicorp/terraform:0.14.11 destroy --var-file=./env/lab.tfvars
```


