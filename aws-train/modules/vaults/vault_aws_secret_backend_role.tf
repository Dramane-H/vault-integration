resource "vault_aws_secret_backend_role" "vault-ec2-admin" {
  backend = vault_aws_secret_backend.aws.path
  name    = "${var.name}-role"
  credential_type = "iam_user"
  policy_document =  <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iam:*", "ec2:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}