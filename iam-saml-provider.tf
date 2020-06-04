resource aws_iam_saml_provider "gsuite" {
  name                   = "${var.org_name}-GSuite"
  saml_metadata_document = var.metadata
}
