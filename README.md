# Kubernetes GitOps Stack (Flux + cert-manager + Vault + App + Traefik + external-dns)

## Overview

This repo deploys a some compnent on k8s to build a website used an automatic certificate via Flux, which include the following components:

- Namespaces
- external-dns (creates DNS records for your hostnames)
- cert-manager (issues TLS certs from Let’s Encrypt or self-signed)
- Vault (Secret management server)
- App (example website with TLS Ingress)
- external-dns
- Traefik (Ingress, LoadBalancer)

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
│  │  ├─ letsencrypt.yaml
│  │  └─ kustomization.yaml
│  └─ vault/
│     ├─ helmrepository.yaml
│     ├─ helmrelease.yaml
│     └─ kustomization.yaml
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

