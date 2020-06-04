resource aws_iam_role clients_read_only {
  count                = length(var.clients)
  name                 = "${var.clients[count.index]}-read-only"
  assume_role_policy   = data.aws_iam_policy_document.gsuite.json
  max_session_duration = var.role_max_session_duration
}

data aws_iam_policy_document clients_read_only_assume {
  count = length(var.clients)
  statement {
    actions   = ["iam:ListAliases"]
    resources = ["*"]
  }
  statement {
    actions = ["sts:AssumeRole"]
    resources = [
      "arn:aws:iam::*:role/${var.clients[count.index]}-*-read-only"
    ]
  }
}

resource aws_iam_role_policy clients_read_only_policy {
  count  = length(var.clients)
  name   = "clients-assume-idp-read-only-${var.clients[count.index]}"
  role   = aws_iam_role.clients_read_only[count.index].id
  policy = data.aws_iam_policy_document.clients_read_only_assume[count.index].json
}



