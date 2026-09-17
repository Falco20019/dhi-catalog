## About this Helm chart

This is a NATS Docker Hardened Helm chart built from the upstream NATS Helm chart and using a hardened configuration
with Docker Hardened Images. It deploys the NATS server as a StatefulSet with the config reloader sidecar and a nats-box
Deployment enabled by default. The optional Prometheus exporter sidecar is image-mapped but disabled by default.

The following Docker Hardened Images are used in this Helm chart:

- `dhi/nats`
- `dhi/nats-server-config-reloader`
- `dhi/nats-box` (compat flavor; chart overrides the upstream startup command so the Deployment stays up without
  coreutils)
- `dhi/prometheus-nats-exporter` (mapped; sidecar disabled by default)

To learn more about how to use this Helm chart you can visit the upstream documentation:
[https://docs.nats.io/running-a-nats-service/nats-kubernetes/helm-charts](https://docs.nats.io/running-a-nats-service/nats-kubernetes/helm-charts)

## About NATS

NATS provides an always-on messaging system, encompassing traditional pubsub with interest-based propagation,
persistence with streaming replays, key/value storage and object storage. NATS provides a flexible set of powerful
authentication and authorisation access controls.

For more details, visit https://nats.io/.

## About Docker Hardened Images

Docker Hardened Images are built to meet the highest security and compliance standards. They provide a trusted
foundation for containerized workloads by incorporating security best practices from the start.

### Why use Docker Hardened Images?

These images are published near-zero known CVEs, include signed provenance, and come with a complete Software Bill of
Materials (SBOM) and VEX metadata. They're designed to secure your software supply chain while fitting seamlessly into
existing Docker workflows.

## Trademarks

NATS™ is a trademark of the Linux Foundation. All rights in the mark are reserved to the Linux Foundation. Any use by
Docker is for referential purposes only and does not indicate sponsorship, endorsement, or affiliation.
