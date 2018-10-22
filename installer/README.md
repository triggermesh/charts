
# Automated installer

Scripted in-cluster install of Knative.
Our primary goal is repeatability,
rather than configurability.

## Development

With Minikube running:

```
eval $(minikube docker-env)
rm -rf ./w; cloud-build-local --write-workspace=./w --dryrun=false .
docker build -t knative.registry.svc.cluster.local/triggermesh/knative-installer --file ./installer/Dockerfile ./w
kubectl -n kube-system run -i -t knative-installer-dev --image=knative.registry.svc.cluster.local/triggermesh/knative-installer --image-pull-policy=Never --restart=Never --rm --command -- bash
```

The registry name is from https://github.com/triggermesh/knative-local-registry.

The install script can also be invoked directly,
with helm flags such as `--set` and `-f`:

```
kubectl -n kube-system run -i -t knative-installer --image=knative.registry.svc.cluster.local/triggermesh/knative-installer --image-pull-policy=Never --restart=Never --rm --command -- ./install-knative.sh --set 'domain=minikube,istioIngressType=NodePort'
```

### With Kaniko

TODO

```
docker run --rm -v $(pwd)/w:/workspace --name kaniko --entrypoint /busybox/sh -ti -w /workspace gcr.io/kaniko-project/executor:debug@sha256:30ba460a034a8051b3222a32e20cb6049741e58384e3adf8c8987c004e2f2ab9
```
