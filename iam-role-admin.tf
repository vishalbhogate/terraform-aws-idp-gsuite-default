resource aws_iam_role admin {
  name                 = "${var.org_name}-admin"
  assume_role_policy   = data.aws_iam_policy_document.gsuite.json
  max_session_duration = var.role_max_session_duration
}

data aws_iam_policy_document admin_policy {
  statement {
    actions   = ["iam:ListAliases"]
    resources = ["*"]
  }

  statement {
    actions = ["sts:AsssumeRole"]
    resources = [
      "arn:aws:iam::*:role/${var.org_name}-*-admin",
      "arn:aws:iam::*:role/terraform-backend"
    ]
  }
}


resource aws_iam_role_policy admin {
  name   = "${var.org_name}-admin"
  role   = aws_iam_role.admin.id
  policy = data.aws_iam_policy_document.admin_policy.json

}

resource aws_iam_group admin {
  name = "assume-idp-admin-group"
}

resource aws_iam_group_policy admin_assume {
  name   = "assume-idp-admin-group"
  group  = aws_iam_group.admin.name
  policy = data.aws_iam_policy_document.admin_policy.json
}

