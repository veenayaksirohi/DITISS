## create a replica set to create 10 pods of nginx with port 80 exposed

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: rs2
spec:
  replicas: 10
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: container1
          image: nginx
          ports:
            - containerPort: 80
              protocol: TCP
```
