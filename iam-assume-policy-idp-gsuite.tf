data aws_iam_policy_document "gsuite" {
  statement {
    actions = ["sts:AssumeRoleWithSAML"]
    principals {
      type = "Federated"
      identifiers = [
        aws_iam_saml_provider.gsuite.arn
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "SAML:aud"

      values = [
        "https://signin.aws.amazon.com/saml"
      ]
    }
  }
}
