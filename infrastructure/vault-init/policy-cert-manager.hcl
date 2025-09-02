path "pki*" {
  capabilities = ["read", "list"]
}
path "pki/sign/website" {
  capabilities = ["create", "update"]
}
path "pki/issue/website" {
  capabilities = ["create"]
}
