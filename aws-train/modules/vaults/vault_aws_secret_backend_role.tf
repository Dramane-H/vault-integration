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
        "iam:*", "ec2:*",
        "iam:CreateAccessKey",
        "iam:CreateUser",
        "iam:PutUserPolicy",
        "iam:ListGroupsForUser",
        "iam:ListUserPolicies",
        "iam:ListAccessKeys",
        "iam:DeleteAccessKey",
        "iam:DeleteUserPolicy",
        "iam:RemoveUserFromGroup",
        "iam:DeleteUser"
      ],
      "Resource": [
                "arn:aws:iam::redacted-account-number:user/vault-*"
            ]
    }
  ]
}
EOF
}
