variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "name" { default = "vault-ec2-admin"}
variable "role" { default = "vault-ec2-admin"}
variable "region" { default = "eu-west-3"}
variable "vault_addr" { default = "http://127.0.0.1:8200" }
variable "vault_token" { default = "hvs.4x02OZieiONUuJwea5ernpHd"}
variable "path" { default = "../modules/vaults/terraform.tfstate" }
