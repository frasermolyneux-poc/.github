cd terraform

terraform init --backend-config=backends/prd.backend.hcl

terraform plan -var-file="tfvars/prd.tfvars"

terraform apply -var-file="tfvars/prd.tfvars"

terraform destroy -var-file="tfvars/prd.tfvars"
