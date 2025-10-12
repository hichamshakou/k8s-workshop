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
    Given wait for condition=Ready on Kubernetes custom resource Kustomization/cert-manager in kustomizations.kustomize.toolkit.fluxcd.io/v1
    Given wait for condition=Ready on Kubernetes custom resource Kustomization/cert-manager-issuers in kustomizations.kustomize.toolkit.fluxcd.io/v1
    Given wait for condition=Ready on Kubernetes custom resource Kustomization/apps-website in kustomizations.kustomize.toolkit.fluxcd.io/v1
  
  # Scenario: check the website app is up
  #   Given Kubernetes namespace website
  #   Given URL: http://testhicham.com/
  #   When send GET /
  #   Then receive HTTP 200 OK


  Scenario: Metrics Endpoint
    Given URL: http://testhicham.com
    #And HTTP request header Host="testhicham.com"
    #And HTTP client "insecureClient"
    When send GET /
    Then receive HTTP 200 OK




#test gpg