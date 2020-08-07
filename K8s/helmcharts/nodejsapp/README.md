# nodejsapp

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: 12](https://img.shields.io/badge/AppVersion-12-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://raw.githubusercontent.com/jerry619/helmcharts/master | postgres | 9.6.5 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  To set affinity |
| containerports.port1.name | string | `"nodejsport"` | Container port name |
| containerports.port1.port | int | `8080` | Container port |
| containerports.port1.protocol | string | `"TCP"` | Container port protocol |
| deployment.maxSurge | int | `1` | Rolling update strategy maxSurge value |
| deployment.maxUnavailable | int | `1` | Rolling update maxUnavailable value |
| deployment.minReadySeconds | int | `6` | Rolling update minReadySeconds value |
| deployment.revisionHistoryLimit | int | `10` | Rolling update revision  |
| deployment.terminationGracePeriodSeconds | int | `10` | Termination grace period seconds |
| image.pullPolicy | string | `"Always"` | Image pull policy |
| image.repository | string | `"jjjje/nodejsapp"` | Image repository |
| image.tag | string | `"latest"` | Image tag |
| imagePullSecrets | list | `[]` | Image pull secrets list |
| ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` | Annotations to use nginx ingress |
| ingress.enabled | bool | `true` | Inress state |
| ingress.hosts[0].host | string | `"minikube.local"` | Ingress host name  |
| ingress.hosts[0].paths[0] | string | `"/"` | Ingress path |
| ingress.tls | list | `[]` | Ingress TLS list |
| livenessProbe.initialDelaySeconds | int | `10` | Initial delay seconds liveness probe |
| livenessProbe.path | string | `"/health-check"` | Liveness probe path |
| livenessProbe.periodSeconds | int | `5` | Liveness probe period |
| nodeSelector | object | `{}` | If you want to select node this pod is launched |
| podSecurityContext | object | `{}` | Security ontext for pods |
| readinessProbe.initialDelaySeconds | int | `10` | Initial delay seconds for readiness probe |
| readinessProbe.path | string | `"/health-check"` | Path to check readiness probe |
| readinessProbe.periodSeconds | int | `5` | Period for readiness probe |
| replicaCount | int | `2` | Number of replica pods |
| resources.limits.cpu | string | `"100m"` | CPU limit specification |
| resources.limits.memory | string | `"128Mi"` | Memory limit specification |
| resources.requests.cpu | string | `"100m"` | CPU request specification |
| resources.requests.memory | string | `"128Mi"` | Memory request specification  |
| securityContext.fsGroup | int | `1000` | Security conext fsgroup  |
| securityContext.runAsNonRoot | bool | `true` | Run as non-root user |
| securityContext.runAsUser | int | `1000` | To run as specific user |
| service.nodeport | int | `30008` | NodePort port number  |
| service.port | int | `80` | service port number |
| service.type | string | `"NodePort"` | Service type |
| tolerations | list | `[]` | Tolerations list |
# postgres

![Version: 9.6.5](https://img.shields.io/badge/Version-9.6.5-informational?style=flat-square) ![AppVersion: 9.6.5](https://img.shields.io/badge/AppVersion-9.6.5-informational?style=flat-square)

A Helm chart for postgres

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity map |
| containerports.port1.name | string | `"postgresport"` | Container port name  |
| containerports.port1.port | int | `5432` | Container port |
| containerports.port1.protocol | string | `"TCP"` | Container port protocol |
| deployment.maxSurge | int | `1` | Rolling update strategy maxSurge value |
| deployment.maxUnavailable | int | `0` | Rolling update maxUnavailable value |
| deployment.minReadySeconds | int | `6` | Rolling update minReadySeconds value |
| deployment.revisionHistoryLimit | int | `10` | Rolling update revision |
| deployment.terminationGracePeriodSeconds | int | `30` | Termination grace period seconds |
| image.pullPolicy | string | `"Always"` | Image pull policy |
| image.repository | string | `"postgres"` | Image repository  |
| image.tag | string | `"9.6.5"` | Image tag |
| imagePullSecrets | list | `[]` | Image pull secrets list |
| ingress.enabled | bool | `false` | Inress details  |
| livenessProbe.initialDelaySeconds | int | `10` | Initial delay seconds liveness probe |
| livenessProbe.periodSeconds | int | `5` | Period liveness probe is checked |
| nodeSelector | object | `{}` | If you want to select node where this pod is launched |
| readinessProbe.initialDelaySeconds | int | `10` | Probe for rediness initial delay seconds |
| readinessProbe.periodSeconds | int | `5` | Period for readiness probe |
| replicaCount | int | `1` | Number of replica pods |
| resources.limits.cpu | string | `"100m"` | CPU limit specification  |
| resources.limits.memory | string | `"128Mi"` | memory limit specification |
| resources.requests.cpu | string | `"100m"` | CPU request specification |
| resources.requests.memory | string | `"128Mi"` | memory request specification |
| secret.db | string | `"nodejsapppostdb"` | DB name stored as secret |
| secret.password | string | `"Ny8jV2Mpsw4few$32!"` | DB password stored as secret  |
| secret.user | string | `"postgres"` | DB username stored as secret |
| securityContext | object | `{}` | Security context map |
| service.port | int | `5432` | Service port  |
| service.type | string | `"ClusterIP"` | Service type |
| tolerations | list | `[]` | Toleration list |
| volume.accessModes[0] | string | `"ReadWriteOnce"` | Volume access mode |
| volume.capacity.storage | string | `"2Gi"` | Storage capacity |
| volume.hostPath | string | `"/data/postgres-pvjjk"` | Host path to mount |
| volume.mountPath | string | `"/var/lib/postgresql/data"` | Mount path on pod |
| volume.name | string | `"postgres-volume-mount"` | Name of volume |
| volume.storageClassName | string | `"standard"` | Storage class name |
