# This role (client-admin) allows switching to any client

data aws_iam_policy_document client_all_admin_assume_policy {
  statement {
    actions   = ["iam:ListAliases"]
    resources = ["*"]
  }

  statement {
    actions   = ["sts:AssumeRole"]
    resources = ["*"]
  }
}


resource aws_iam_role client_all_admin {
  name                 = "client-admin"
  assume_role_policy   = data.aws_iam_policy_document.gsuite.json
  max_session_duration = var.role_max_session_duration
}

resource aws_iam_role_policy client_all_admin_assume {
  name   = "clients-all-assume-idp-admin"
  role   = aws_iam_role.client_all_admin.id
  policy = data.aws_iam_policy_document.client_all_admin_assume_policy.json
}
