module "ec2" {
  
}

module "network" {
  
}

module "vault" {
  
}

module "s3" {
  
}

module "ha-scaling" {
  
}

module "monitor" {
  
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
}