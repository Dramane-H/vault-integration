data "terraform_remote_state" "admin" {
  backend = "local"

  config = {
    path = "../vaults/terraform.tfstate"
  }
}


data "vault_aws_access_credentials" "creds" {
  backend = data.terraform_remote_state.admin.outputs.backend
  role    = data.terraform_remote_state.admin.outputs.role
  region  = var.region
}


resource "aws_s3_bucket" "example" {
  bucket = "EmployePhotoBucket"

  tags = {
    Name        = "employeeDir"
    Environment = "Dev"
  }
}


resource "aws_s3_bucket_acl" "example" {

  bucket = aws_s3_bucket.example.id
  acl    = "private"
}