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