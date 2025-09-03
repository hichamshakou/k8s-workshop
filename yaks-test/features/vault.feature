Feature: Vault unseal status

  Scenario: Check Vault is unsealed
    Given Kubernetes Namespace vault
    When I run "kubectl -n vault exec vault-0 -- vault status -format=json"
    Then the command output should contain "\"sealed\":false"
    And the command output should contain "\"initialized\":true"