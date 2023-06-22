terraform {
  backend "s3" {
    path = "terraform.tfstate"
  }
}