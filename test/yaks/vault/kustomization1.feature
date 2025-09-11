Feature: Verify Vault workload is up

  Background:
    Given Kubernetes resource polling configuration
      | maxAttempts          | 20   |
      | delayBetweenAttempts | 2000 |

  Scenario: check vault namespace exists
    Given Kubernetes namespace vault
    Then Kubernetes pod vault-0 is running
  
  Scenario: check kustomization vault 
    Given Kubernetes namespace flux-system
    Given wait for condition=Ready on Kubernetes custom resource Kustomization/vault in kustomizations.kustomize.toolkit.fluxcd.io/v1