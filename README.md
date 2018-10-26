# Chart for Knative

It installs the released manifest for knative, including Istio as [documented](https://github.com/knative/docs/blob/master/install/Knative-with-any-k8s.md)

Note that because of Istio [RBAC](https://istio.io/docs/setup/kubernetes/helm-install/#installation-steps)
you need Helm 2.10 or later.

## Setup the Chart repo

```
helm repo add tm gs://triggermesh-charts
```

or if you don't have the cloud storage plugin use http:

```
helm repo add tm https://storage.googleapis.com/triggermesh-charts
```

And update your chart repos:

```
helm repo update
```

## Search for knative and install

```
helm search knative
helm install --debug --dry-run tm/knative
```

If you are sure you want to do the install:

```
helm install tm/knative
```

## Building

This chart is built via Google Cloud build, check `cloudbuild.yaml`

## Support

We would love your feedback on this chart so don't hesitate to let us know what is wrong and how we could improve it, just file an [issue](https://github.com/triggermesh/charts/issues/new)

## Code of Conduct

This plugin is by no means part of [CNCF](https://www.cncf.io/) but we abide by its [code of conduct](https://github.com/cncf/foundation/blob/master/code-of-conduct.md)
