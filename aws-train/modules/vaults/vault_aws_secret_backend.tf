resource "vault_aws_secret_backend" "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_access_key
  path = "${var.name}-path"
  region = var.region

  default_lease_ttl_seconds = "120"
  max_lease_ttl_seconds     = "240"
}
