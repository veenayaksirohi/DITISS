# Kubernetes

## VS Code extensions

- https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml
- https://marketplace.visualstudio.com/items?itemName=ipedrazas.kubernetes-snippets

## minikube

```bash

# linux
> curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
> sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

# macOS - x86
> curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-darwin-amd64
> sudo install minikube-darwin-amd64 /usr/local/bin/minikube

# macOS - arm
> curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-darwin-arm64
> sudo install minikube-darwin-arm64 /usr/local/bin/minikube

# check the status of cluster
> minikube status

# start minikube cluster
> minikube start

# stop the cluster
# - it will not remove the cluster / virtual machine
> minikube stop

# delete the cluster
> minikube delete

# get the minikube dashboard (control plane)
> minikube dashboard

# ssh to minikube virtual machine
> minikube ssh

# add minikube kubectl in bashrc
> vim ~/.bashrc
# add the following line
> alias kubectl="minikube kubectl --"

```

## cluster

```bash

# get the cluster information
> kubectl cluster-info

# get detailed information about the cluster
> kubectl cluster-info dump

# get all api versions supported
> kubectl api-versions

```

## nodes

```bash

# get the list of nodes
> kubectl get nodes

```

## namespace

```bash

# get the list of namespaces
> kubectl get namespaces
> kubectl get ns

# get all the resources created from a ns
# > kubectl get all -n <ns name>
> kubectl get all -n kube-system

# create a namespace
> kubectl create ns myns

# delete a selected namespace
# note: everything inside ns will also get deleted
# > kubectl delete ns <ns name>
> kubectl delete ns myns

```

## pod

```bash

# get the list of pods
> kubectl get pods

# get the list of pods with more details
> kubectl get pods -o wide

# run application inside a pod (imperative command)
# > kubectl run <pod name> --image <image>
> kubectl run httpd --image httpd

# create a new pod inside myns namespace
# > kubectl run <pod name> --image <image>
> kubectl run httpd --image httpd -n myns

# create a pod using yaml file
# > kubectl create -f <file name>

# get details of a selected pod
# > kubectl describe pod <pod name>
> kubectl describe pod httpd

```

## replica set

```bash

```

## deployment

```bash

```

## service

```bash

```

## persistent volume

```bash

```

## persistent volume claim

```bash

```

## config map

```bash

```

## secret

```bash

```

## prometheus

```bash

```

## grafana

```bash

```

# helm

## installation

```bash

# macOS
> brew install helm

# ubuntu
> sudo apt-get install curl gpg apt-transport-https --yes
> curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
> echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" | > sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
> sudo apt-get update
> sudo apt-get install helm

# verify installation
> helm --version

```
