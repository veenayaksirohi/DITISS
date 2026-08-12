# Kubernetes

## minikube

```bash

# download the minikube
> curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64

# install the minikube
> sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

# open bashrc
> vim ~/.bashrc

# add this line at the bottom
alias kubectl="minikube kubectl --"

# reload the bashrc settings
> source ~/.bashrc

# check the settings
> kubectl get nodes

# run the watch command for pods
> watch -n 1 minikube kubectl -- get pods

```

## minikube commands

```bash

# start the cluster
> minikube start

# check the status
> minikube status

# ssh to the minikube virtual machine
> minikube ssh

```

## node commands

```bash

# get the list of nodes
> kubectl get nodes

# get details of selected node
# > kubectl describe node <node name>
> kubectl describe node minikube

# remove a node
# > kubectl delete node <node name>

```

## namespace commands

```bash

# get the list of namespaces
> kubectl get namespaces
> kubectl get ns

# create a namespace
# > kubectl create namespace <namespace name>
> kubectl create namespace myns
> kubectl create ns myns

# delete a namespace
# note: all the objects inside a namespace will be deleted
# > kubectl delete namespace <namespace name>
> kubectl delete ns myns

```

## pod commands

```bash

# get the list of pods in default namespace
> kubectl get pods

# get the list of pods along with more information like IP address
> kubectl get pods -o wide

# get the list of pods in a required namespace
# > kubectl get pods -n <namespace name>
> kubectl get pods -n kube-system

# create a pod using yaml file in default namespace
# > kubectl create -f <yaml file>

# get the details of a selected pod
# > kubectl describe pod <pod name>
> kubectl describe pod pod1

# delete a selected pod
# > kubectl delete pod <pod name>
> kubectl delete pod pod1

```

## replicaset commands

```bash

# get the list of replica sets
> kubectl get replicasets
> kubectl get rs

# create replica set using yaml file
# > kubectl create -f <yaml file>

# apply the new changes from yaml file
# > kubectl apply -f <yaml file>

```

## deployment commands

```bash

# get the list of deployments
> kubectl get deployments

# create a deployment
# > kubectl create -f <yaml file>

```
