data "terraform_remote_state" "admin" {
  backend = "local"

  config = {
    path = var.path
  }
} 
