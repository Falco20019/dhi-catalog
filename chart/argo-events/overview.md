## About this Helm chart

This is an Argo Events Docker Hardened Helm chart built from the upstream Argo Events Helm chart and using a hardened
configuration with Docker Hardened Images.

The following Docker Hardened Images are used in this Helm chart:

- `dhi/argo-events`
- `dhi/nats` (JetStream EventBus)
- `dhi/prometheus-nats-exporter` (JetStream EventBus)
- `dhi/nats-server-config-reloader` (JetStream EventBus)

To learn more about how to use this Helm chart you can visit the upstream documentation:
[https://github.com/argoproj/argo-helm/tree/main/charts/argo-events](https://github.com/argoproj/argo-helm/tree/main/charts/argo-events)

## About Argo Events

Argo Events is an event-driven workflow automation framework for Kubernetes. It can take events from a variety of
sources and trigger Kubernetes resources such as Argo Workflows, Jobs, and other custom resources.

For more details, visit https://argoproj.github.io/argo-events/

## About Docker Hardened Images

Docker Hardened Images are built to meet the highest security and compliance standards. They provide a trusted
foundation for containerized workloads by incorporating security best practices from the start.

### Why use Docker Hardened Images?

These images are published with near-zero known CVEs, include signed provenance, and come with a complete Software Bill
of Materials (SBOM) and VEX metadata. They're designed to secure your software supply chain while fitting seamlessly
into existing Docker workflows.

## Trademarks

Argo® is a trademark of the Linux Foundation. All rights in the mark are reserved to the Linux Foundation. Any use by
Docker is for referential purposes only and does not indicate sponsorship, endorsement, or affiliation.
