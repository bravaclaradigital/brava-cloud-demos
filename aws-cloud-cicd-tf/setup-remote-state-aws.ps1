# Setup AWS S3 and DynamoDB for Terraform Remote State
# Run this once before using the AWS workflows

Write-Host "Setting up AWS remote state storage..." -ForegroundColor Cyan

$BUCKET_NAME = "brava-tfstate-812326499495"
$DYNAMODB_TABLE = "brava-terraform-locks"
$REGION = "us-east-1"

# Create S3 bucket
Write-Host "Creating S3 bucket..." -ForegroundColor Yellow
aws s3api create-bucket `
  --bucket $BUCKET_NAME `
  --region $REGION

# Enable versioning
Write-Host "Enabling versioning..." -ForegroundColor Yellow
aws s3api put-bucket-versioning `
  --bucket $BUCKET_NAME `
  --versioning-configuration Status=Enabled

# Enable encryption
Write-Host "Enabling encryption..." -ForegroundColor Yellow
aws s3api put-bucket-encryption `
  --bucket $BUCKET_NAME `
  --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

# Block public access
Write-Host "Blocking public access..." -ForegroundColor Yellow
aws s3api put-public-access-block `
  --bucket $BUCKET_NAME `
  --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"

# Create DynamoDB table for state locking
Write-Host "Creating DynamoDB table for state locking..." -ForegroundColor Yellow
aws dynamodb create-table `
  --table-name $DYNAMODB_TABLE `
  --attribute-definitions AttributeName=LockID,AttributeType=S `
  --key-schema AttributeName=LockID,KeyType=HASH `
  --billing-mode PAY_PER_REQUEST `
  --region $REGION

Write-Host "`nAWS remote state storage created successfully!" -ForegroundColor Green
Write-Host "S3 Bucket: $BUCKET_NAME"
Write-Host "DynamoDB Table: $DYNAMODB_TABLE"
Write-Host "Region: $REGION"
Write-Host "`nNext: Run 'terraform init -migrate-state' in aws-cloud-cicd-tf/" -ForegroundColor Cyan
