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



module "ec2" {
  source = "github.com/Dramane-H/vault-integration/tree/week-4/aws-train/modules/ec2"
}

/* module "network" {
  source = "github.com/username/repository"
}

module "vault" {
  source = "github.com/username/repository"
}

module "s3" {
  source = "github.com/username/repository"
}

module "ha-scaling" {
  source = "github.com/username/repository"
}

module "monitor" {
  source = "github.com/username/repository"
}

resource "aws_prometheus_workspace" "demo" {
    alias = "example"

    tags = {
         Environment = "production"
  }
}


resource "aws_prometheus_alert_manager_definition" "demo" {
  workspace_id = aws_prometheus_workspace.demo.id
  definition   = <<EOF
alertmanager_config: |
  route:
    receiver: 'default'
  receivers:
    - name: 'default'
EOF
} */