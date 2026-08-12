# exercise 1

- create 3 micro services: user-service, order-service and product service

```bash



# build the order service image
> cd order-service
> docker image build -t order-service .

# create container for order service
> docker container run -d --name order-service -p 4001:4000 order-service


# build the user service image
> cd user-service
> docker image build -t user-service .

# create container for user service
> docker container run -d --name user-service -p 4002:4000 user-service


# build the product service image
> cd product-service
> docker image build -t product-service .

# create container for product service
> docker container run -d --name product-service -p 4003:4000 product-service

```
