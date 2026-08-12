# Kubernetes

## minikube

```bash

# download the minikube
> curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64

# install the minikube
> sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

# start the cluster
> minikube start

# check the status
> minikube status

# open bashrc
> vim ~/.bashrc

# add this line at the bottom
alias kubectl="minikube kubectl --"

# reload the bashrc settings
> source ~/.bashrc

# check the settings
> kubectl get nodes


```
