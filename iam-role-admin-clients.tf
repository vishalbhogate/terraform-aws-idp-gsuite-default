# This role (<name>-admin) allows switching just to a specific client

resource aws_iam_role clients_admin {
  count                = length(var.clients)
  name                 = "${var.clients[count.index]}-admin"
  assume_role_policy   = data.aws_iam_policy_document.gsuite.json
  max_session_duration = var.role_max_session_duration
}

data aws_iam_policy_document client_admin_assume_policy {
  count = length(var.clients)
  statement {
    actions   = ["iam:ListAliases"]
    resources = ["*"]
  }

  statement {
    actions = ["sts:AssumeRole"]
    resources = [
      "arn:aws:iam::*:role/${var.clients}-*-admin",
      "arn:aws:iam::*:role/terraform-backend"
    ]
  }
}

resource aws_iam_role_policy client_admin_policy {
  count  = length(var.clients)
  name   = "client-assueme-idp-admin-${var.clients[count.index]}"
  role   = aws_iam_role.clients_admin[count.index].id
  policy = data.aws_iam_policy_document.client_admin_assume_policy[count.index].json
}
