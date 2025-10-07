# Kubernetes GitOps Stack (Flux + cert-manager + Vault + App + Traefik + external-dns)

## Overview

This repo deploys a some compnent on k8s to build a website used an automatic certificate via Flux, which include the following components:

- Namespaces
- cert-manager (issues TLS certs from Let’s Encrypt or self-signed)
- Vault (Secret management server)
- Vault-init
- App (example website with TLS Ingress)
- external-dns
- Traefik (Ingress, LoadBalancer)
- olm (Operator Lifecycle Manager)
- yaks (Kubernetes Acceptance Tests) + kuttle (Kustomize testing tool)

## Directory layout
```sh
repo-root/
├─ clusters/
│  └─ main/
│     └─ flux-kustomizations.yaml
├─ infrastructure/
│  ├─ namespaces/
│  │  ├─ flux-system-ns.yaml
│  │  ├─ cert-manager-ns.yaml
│  │  ├─ vault-ns.yaml
│  │  ├─ traefik-ns.yaml
│  │  └─ kustomization.yaml
│  ├─ traefik/
│  │  ├─ namespace.yaml
│  │  ├─ helmrepository.yaml
│  │  ├─ helmrelease.yaml
│  │  └─ kustomization.yaml
│  ├─ external-dns/
│  │  ├─ namespace.yaml
│  │  ├─ helmrepository.yaml
│  │  ├─ helmrelease.yaml
│  │  └─ kustomization.yaml
│  ├─ cert-manager/
│  │  ├─ helmrepository.yaml
│  │  ├─ helmrelease.yaml
│  │  └─ kustomization.yaml
│  ├─ cert-manager-issuers/
│  │  ├─ selfsigned.yaml
│  │  ├─ vault-issuer.yaml
│  │  └─ kustomization.yaml
│  └─ vault/
│     ├─ helmrepository.yaml
│     ├─ helmrelease.yaml
│     └─ kustomization.yaml
│  └─ vault-init/
│     ├─ job-auth.yaml
│     ├─ job-pki.yaml
│     ├─ policy-cert-manager.hcl
│     └─ kustomization.yaml
│  └─ yaks/
│     └─ kustomization.yaml
│  └─ olm/
│     ├─ kustomization.yaml
│     ├─ crds.yaml
│     └─ olm.yaml
└─ apps/
   └─ website/
      ├─ namespace.yaml
      ├─ deployment.yaml
      ├─ service.yaml
      ├─ certificate.yaml
      ├─ ingress.yaml
      └─ kustomization.yaml
```

## Bootstrap Flux
flux bootstrap github \
  --owner <GITHUB_USER_OR_ORG> \
  --repository <REPO_NAME> \
  --branch main \
  --path clusters/dev \
  --personal \
  --token-auth

## Certificate Lifecycle with Vault + cert-manager
```sh
Develop (Git/Flux) (deployment + ingress + certificate)
   ↓
Cert-manager-Controller (CSR testhicham.com)
   ↓
Vault PKI (via API, Signed cert + CA)
   ↓
cert-manager (store in secret)
   ↓
App (mount secret in volume)
```

### Testing

#### Kuttl
inside the folder k8s-workshop/test/kuttle , do the following command:
```sh
cd test/kuttl 
kubectl kuttl test e2e/
```

#### Yaks
inside the folder k8s-workshop/test/yaks , do the following command:
```sh
cd vault
yaks run kustomization1.feature
```


### running github action 
configura a local github runner and run the following to start the runner where the runner folder exist
```
./run.cmd
```