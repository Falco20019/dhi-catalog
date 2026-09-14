## About this Helm chart

This is a trust-manager Docker Helm chart built from the upstream trust-manager Helm chart and using a hardened
configuration with Docker Hardened Images.

The following Docker Hardened Images are used in this Helm chart:

- `dhi/trust-manager`
- `dhi/trust-manager-package`

To learn more about how to use this Helm chart you can visit the upstream documentation:
[https://github.com/cert-manager/trust-manager/tree/main/deploy/charts/trust-manager](https://github.com/cert-manager/trust-manager/tree/main/deploy/charts/trust-manager)

### About trust-manager

trust-manager is the easiest way to manage TLS trust bundles in Kubernetes and OpenShift clusters. It distributes CA
bundles as ConfigMaps or Secrets so workloads can mount a consistent set of trust anchors.

It integrates with cert-manager and supports sourcing trust material from in-cluster resources as well as a default
Debian CA package.

For more information and documentation see https://cert-manager.io/docs/trust/trust-manager/.

## About Docker Hardened Images

Docker Hardened Images are built to meet the highest security and compliance standards. They provide a trusted
foundation for containerized workloads by incorporating security best practices from the start.

### Why use Docker Hardened Images?

These images are published with near-zero known CVEs, include signed provenance, and come with a complete Software Bill
of Materials (SBOM) and VEX metadata. They're designed to secure your software supply chain while fitting seamlessly
into existing Docker workflows.

## Trademarks

Cert Manager™ and Kubernetes® are trademarks of the Linux Foundation. All rights in the mark are reserved to the Linux
Foundation. Any use by Docker is for referential purposes only and does not indicate sponsorship, endorsement, or
affiliation.
