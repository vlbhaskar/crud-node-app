#!/usr/bin/env bash
eval $(minikube docker-env)
docker build -t bhaskar-nodejs .
docker build -t bhaskar-db db
kubectl create -f bhaskar_db_deployment.yml
kubectl create -f bhaskar_db_service.yml
kubectl create -f bhaskar_nodejs_deployment.yml
kubectl create -f bhaskar_nodejs_service.yml
#lanunh nodejs customer service
# curl $(minikube service bhaskar-nodejs-service --url)

#Start service and open the base URL(ex:http://127.0.0.1:50881/) of the service in browser, 
#and then you can access node service with urls like (http://127.0.0.1:50881/api/health, http://127.0.0.1:50881/api/customers)
minikube service bhaskar-nodejs-service 