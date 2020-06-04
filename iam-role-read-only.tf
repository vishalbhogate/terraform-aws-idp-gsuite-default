resource aws_iam_role read_only {
  name                 = "${var.org_name}-read-only"
  assume_role_policy   = data.aws_iam_policy_document.gsuite.json
  max_session_duration = var.role_max_session_duration
}

data aws_iam_policy_document read_only_assume {
  statement {
    actions   = ["iam:ListAliases"]
    resources = ["*"]
  }

  statement {
    actions = ["sts:AssumeRole"]
    resources = [
      "arn:aws:iam::*:role/${var.org_name}-*-read-only"
    ]
  }
}

resource aws_iam_role_policy read_only_policy {
  name   = "assume-idp-read-only"
  role   = aws_iam_role.read_only.id
  policy = data.aws_iam_policy_document.read_only_assume.json
}
