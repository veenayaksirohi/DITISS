# monitoring

## helm

- package manager for kubernetes
- used to install/uninstall/upgrade/downgrade application (chart) in kubernetes

```bash

# install helm on macOS
> brew install helm

```

```bash

# install pre-requisites
> sudo apt-get install curl gpg apt-transport-https --yes

# install the gpg key for prometheus apt repo
> curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null

# add prometheus apt repo
> echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

# update the apt repositories
> sudo apt-get update

# install helm
> sudo apt-get install helm

# verify the installation
> helm version

# get the list of installed charts
> helm list

# get the list of repositories
> helm repo list

```

## prometheus and grafana

```bash

# add the helm repository for prometheus
> helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# download the added repositories
> helm repo update

# install prometheus and grafana (as a stack)
# > helm install <name> <chart>
> helm install monitoring prometheus-community/kube-prometheus-stack

# get the pods created by the monitoring release
> kubectl --namespace default get pods -l "release=monitoring"

# get the services created by monitoring release
> kubectl get svc

# forward the port 9090 from localhost to the pod
> kubectl port-forward svc/monitoring-kube-prometheus-prometheus 9090

# access the prometheus
> visit http://localhost:9090

# get grafana password
> kubectl get secret monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# forward port to access grafana
> kubectl port-forward svc/monitoring-grafana 3000:80

# access the grafana dashboard
# username: admin
# password: copy from the previous command
> visit http://localhost:3000

# add external dashboards
# https://grafana.com/grafana/dashboards/15661-k8s-dashboard-en-20250125/


```

## common PromQL queries

```bash

# get all pods information
> kube_pod_info

# get all nodes information
> kube_node_info

# get the cpu usage on the nodes
> machine_cpu_cores

```
