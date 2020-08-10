#!/bin/sh -xvf

kubectl create namespace elastic-monitoring

# Delete old secrets
kubectl delete secret logging-cloud-secret --namespace=elastic-monitoring
kubectl delete secret cloud-secret --namespace=elastic-monitoring

# test1
cloud_id=...
cloud_auth=...

# logging cluster
logging_cloud_id=...
logging_cloud_auth=...

# Main cluster
kubectl create secret generic cloud-secret --namespace=elastic-monitoring --from-literal=cloud-id=${cloud_id} --from-literal=cloud-auth=${cloud_auth}

# Monitoring cluster
kubectl create secret generic logging-cloud-secret --namespace=elastic-monitoring --from-literal=cloud-id=${logging_cloud_id} --from-literal=cloud-auth=${logging_cloud_auth}
