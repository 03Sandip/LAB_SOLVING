```
gcloud auth list
gcloud config list project
```
###Validate a constraint

```
git clone https://github.com/GoogleCloudPlatform/policy-library.git
cd policy-library/
cp samples/iam_service_accounts_only.yaml policies/constraints
cat policies/constraints/iam_service_accounts_only.yaml
```
```
touch main.tf
```
Replace <YOUR PROJECT ID> with Project ID.
Replace <USER> with Lab username
```
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 3.84"
    }
  }
}

resource "google_project_iam_binding" "sample_iam_binding" {
  project = "<YOUR PROJECT ID>"
  role    = "roles/viewer"

  members = [
    "user:<USER>"
  ]
}
```
```
terraform init
terraform plan -out=test.tfplan
terraform show -json ./test.tfplan > ./tfplan.json
sudo apt-get install google-cloud-sdk-terraform-tools
gcloud beta terraform vet tfplan.json --policy-library=.
```

##Modify the constraint

```
apiVersion: constraints.gatekeeper.sh/v1alpha1
kind: GCPIAMAllowedPolicyMemberDomainsConstraintV1
metadata:
  name: service_accounts_only
spec:
  severity: high
  match:
    target: ["organizations/**"]
  parameters:
    domains:
      - gserviceaccount.com
      - qwiklabs.net
```
```
terraform plan -out=test.tfplan
gcloud beta terraform vet tfplan.json --policy-library=.
terraform apply test.tfplan
```


