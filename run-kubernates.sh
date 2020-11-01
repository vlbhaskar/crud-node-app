#!/usr/bin/env bash
eval $(minikube docker-env)
docker build -t bhaskar-nodejs .
docker build -t bhaskar-db db
kubectl create -f bhaskar_db_deployment.yml
kubectl create -f bhaskar_db_service.yml
kubectl create -f bhaskar_nodejs_deployment.yml
kubectl create -f bhaskar_nodejs_service.yml
curl $(minikube service bhaskar-nodejs-service --url)