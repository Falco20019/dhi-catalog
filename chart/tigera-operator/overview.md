## About this Helm chart

This is a Tigera Operator Docker Hardened Helm chart built from the upstream Calico `tigera-operator` Helm chart and
using a hardened configuration with Docker Hardened Images.

### Differences between Calico 3.32 and 3.33

Two chart lines are published. Both are built from the upstream `tigera-operator` Helm chart, but Calico 3.33 ships a
different set of images, so the two lines are defined and published separately.

| Aspect                                  | 3.32.x                                                         | 3.33.x                                                                                       |
| --------------------------------------- | -------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| Tigera operator version                 | 1.42.x                                                         | 1.44.x                                                                                       |
| Component images                        | One image per component (13 images in total, see below)        | 4 images: `calico-calico`, `calico-node`, `calico-whisker`, `calico-third-party-cni-plugins` |
| `calicoctl` init container (OpenShift)  | `dhi/calico-ctl`                                               | `dhi/calico-calico` (the combined image ships `/usr/bin/calicoctl`)                          |
| Controllers, Typha, CNI, CSI, webhooks… | Separate images (`calico-kube-controllers`, `calico-typha`, …) | Provided by the combined `dhi/calico-calico` image                                           |
| Goldmane and Whisker backend            | `dhi/calico-goldmane`, `dhi/calico-whisker-backend`            | Provided by the combined `dhi/calico-calico` image                                           |
| CNI install                             | `dhi/calico-cni`                                               | `dhi/calico-calico`, plus the `dhi/calico-third-party-cni-plugins` init container            |

The sections below describe the 3.32.x chart unless stated otherwise. See
[Images referenced in the Helm chart (3.33.x)](#images-referenced-in-the-helm-chart-333x) for the 3.33.x chart.

### Images referenced in the Helm chart (3.32.x, digest-pinned at build)

These images are wired directly into chart templates and tracked in the chart build:

- `dhi/tigera-operator` — the Tigera operator that installs and reconciles Calico components
- `dhi/calico-ctl` — calicoctl init container on OpenShift installs (upstream chart template)

There are other images controlled by chart values (`whisker.enabled`, and so on)

### Images deployed by the operator (3.32.x, `installation.registry` / `installation.imagePrefix`)

The operator resolves Calico component images at runtime (default layout: `dhi.io/calico-<component>:v<version>`). Set
`installation.imagePath` when mirroring into a registry namespace (for example `dhi` on `docker.io`).

| DHI image                          | Role                                       | Typical trigger                                    |
| ---------------------------------- | ------------------------------------------ | -------------------------------------------------- |
| `dhi/calico-cni`                   | CNI plugin (`install-cni` init)            | Core install                                       |
| `dhi/calico-node`                  | Node agent (Felix, BIRD/eBPF, routing)     | Core install                                       |
| `dhi/calico-kube-controllers`      | Controllers (IPAM, policy sync, and so on) | Core install                                       |
| `dhi/calico-typha`                 | Control-plane fan-out proxy for Felix      | Autoscaler (often ≥1 replica)                      |
| `dhi/calico-apiserver`             | Legacy aggregation API (API-server mode)   | `apiServer.enabled: true` (legacy path)            |
| `dhi/calico-webhooks`              | Admission policies for native v3 CRDs      | `apiServer.enabled: true` (v3 CRD path)            |
| `dhi/calico-csi`                   | CSI driver for Felix policy-sync socket    | CSI enabled (`kubeletVolumePluginPath` not `None`) |
| `dhi/calico-node-driver-registrar` | CSI node-driver-registrar sidecar          | CSI enabled                                        |
| `dhi/calico-pod2daemon-flexvol`    | Legacy FlexVolume init                     | FlexVolume enabled (deprecated path)               |
| `dhi/calico-goldmane`              | Flow log aggregator                        | `goldmane.enabled: true`                           |
| `dhi/calico-whisker`               | Observability UI                           | `whisker.enabled: true`                            |
| `dhi/calico-whisker-backend`       | Observability backend API                  | `whisker.enabled: true`                            |

Lean networking installs enable only the core rows. Policy, observability, and CSI features enable additional rows via
chart values or the `Installation` CR.

### Images referenced in the Helm chart (3.33.x)

The 3.33.x chart references these images, all digest-pinned at build:

- `dhi/tigera-operator` — the Tigera operator that installs and reconciles Calico components
- `dhi/calico-calico` — combined Calico image, also used by the `calicoctl` init container of the operator pod
  (OpenShift installs)
- `dhi/calico-node` — node agent (Felix, BIRD/eBPF, routing)
- `dhi/calico-whisker` — observability UI
- `dhi/calico-third-party-cni-plugins` — init container that stages the upstream CNI plugins (host-local, portmap,
  loopback, tuning, flannel) on each node

Only `dhi/tigera-operator` and `dhi/calico-calico` (as `calicoctl.image`) are set directly in the chart values. The
operator deploys the Calico component images itself from `installation.registry`, `installation.imagePath` and
`installation.imagePrefix`, resolving each reference as `<registry>/<imagePath>/<imagePrefix><component>`, where the
component is `calico`, `node`, `whisker` or `third-party-cni-plugins`.

| DHI image                            | Role                                                                                  | Typical trigger                    |
| ------------------------------------ | ------------------------------------------------------------------------------------- | ---------------------------------- |
| `dhi/calico-calico`                  | Combined Calico binary: CNI install, controllers, Typha, webhooks, Goldmane, CSI, ctl | Core install and optional features |
| `dhi/calico-node`                    | Node agent (Felix, BIRD/eBPF, routing)                                                | Core install                       |
| `dhi/calico-third-party-cni-plugins` | Upstream CNI plugins staged before `install-cni` runs                                 | Core install                       |
| `dhi/calico-whisker`                 | Observability UI                                                                      | `whisker.enabled: true`            |

To learn more about how to use this Helm chart you can visit the upstream documentation:
[https://github.com/projectcalico/calico/tree/master/charts/tigera-operator](https://github.com/projectcalico/calico/tree/master/charts/tigera-operator)

## About Tigera Operator

The Tigera Operator is a Kubernetes operator that installs, configures, and manages Calico networking and policy
components. It reconciles custom resources such as `Installation` to deploy Calico as the cluster CNI and optional
policy engine.

For more details, visit https://docs.tigera.io/calico/latest/operations/installing-with-helm.

## About Docker Hardened Images

Docker Hardened Images are built to meet the highest security and compliance standards. They provide a trusted
foundation for containerized workloads by incorporating security best practices from the start.

### Why use Docker Hardened Images?

These images are published with near-zero known CVEs, include signed provenance, and come with a complete Software Bill
of Materials (SBOM) and VEX metadata. They're designed to secure your software supply chain while fitting seamlessly
into existing Docker workflows.

## Trademarks

Calico® is a trademark of Tigera, Inc. All rights in the mark are reserved to Tigera, Inc. Any use by Docker is for
referential purposes only and does not indicate sponsorship, endorsement, or affiliation.
