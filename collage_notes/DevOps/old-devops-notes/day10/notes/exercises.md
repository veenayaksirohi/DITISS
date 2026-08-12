# exercise 1

- create a pod to run httpd image

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: httpd
  labels:
    app: httpd
spec:
  containers:
    - name: httpd-container
      image: httpd
      ports:
        - containerPort: 80
          protocol: TCP
```

```bash

# create httpd pod
> kubectl create -f httpd.yaml

```

- create a pod to run mysql image

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mysql
  labels:
    app: mysql
spec:
  containers:
    - name: container-mysql
      image: mysql
      ports:
        - containerPort: 3306
      env:
        - name: MYSQL_ROOT_PASSWORD
          value: root
        - name: MYSQL_DATABASE
          value: mydatabase
```

```bash

# create mysql pod
> kubectl create -f mysql.yaml

```

# exercise 2

- create 7 pods of httpd image
- go inside any of the pods and get the output of curl localhost command
- send a http request to one of the pods

# exercise 3

- create 5 pods of nginx
- load balance all of them using a service
