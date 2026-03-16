terraform {
  backend "s3" {
    # Bucket name and DynamoDB table are passed at init time via -backend-config
    # flags or a backend.hcl file (see backend.hcl.example).
    # This keeps account-specific values out of version control.
    #
    # Local init:
    #   terraform init -backend-config=backend.hcl
    #
    # CI/CD (GitHub Actions):
    #   Secrets: AWS_TF_STATE_BUCKET, AWS_TF_LOCK_TABLE
    key     = "aws-cloud-cicd/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
