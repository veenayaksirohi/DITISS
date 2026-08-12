```bash

# create a service with nginx image with 10 replicas
> docker service create --name nginx --replicas 10 -p 8000:80 nginx

# check the status
> docker service ps nginx

# scale it up to 15 containers
> docker service scale nginx=15

# scale it down to 5 contianers
> docker service scale nginx=5

# remove the service
> docker service rm nginx

```
