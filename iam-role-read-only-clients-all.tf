resource aws_iam_role client_all_read_only {
  name                 = "client-read-only"
  assume_role_policy   = data.aws_iam_policy_document.gsuite.json
  max_session_duration = var.role_max_session_duration
}

data aws_iam_policy_document client_all_read_only_assume {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = ["*"]
  }

  statement {
    actions   = ["iam:ListAliases"]
    resources = ["*"]
  }
}

resource aws_iam_role_policy client_all_read_only_policy {
  name   = "assume-idp-client-all-read-only"
  role   = aws_iam_role.client_all_read_only.id
  policy = data.aws_iam_policy_document.client_all_read_only_assume.json
}
