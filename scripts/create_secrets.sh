#!/bin/sh -xvf

kubectl create namespace elastic-monitoring

# Delete old secrets
kubectl delete secret logging-cloud-secret --namespace=elastic-monitoring
kubectl delete secret cloud-secret --namespace=elastic-monitoring

# test1
cloud_id=test1:YXVzdHJhbGlhLXNvdXRoZWFzdDEuZ2NwLmVsYXN0aWMtY2xvdWQuY29tJDdkNmVmZGMwZGQ0MDQ3NmU5YTYzZTg3MWI0ZTIxZTQxJGZhMjZkZTI3ZmUzNDQ0OTliZjI2NDMwNzY3MDliODU4
cloud_auth=elastic:qT24HHa18eoUmnmKKAzo3550

# logging cluster
logging_cloud_id=logging-cluster-1:YXVzdHJhbGlhLXNvdXRoZWFzdDEuZ2NwLmVsYXN0aWMtY2xvdWQuY29tJDdjYjRhZWJiNzcyNjRiM2ZhNTVhNzcyMGVhZGQyMTg2JDJkMzUxMWI3N2VjODQzOTdiMmYxMGJlZDc1ZmZmY2Uw
logging_cloud_auth=elastic:dKHrftOaM04LU2AYHJaLPjXO
logging_cluster_uuid=loq7p-fYRLK4eEd6UNbPtg

# Main cluster
kubectl create secret generic cloud-secret --namespace=elastic-monitoring \
  --from-literal=cloud-id=${cloud_id} \
  --from-literal=cloud-auth=${cloud_auth}

# Monitoring cluster
kubectl create secret generic logging-cloud-secret --namespace=elastic-monitoring\
  --from-literal=cloud-id=${logging_cloud_id} \
  --from-literal=cloud-auth=${logging_cloud_auth} \
  --from-literal=cluster-uuid=${logging_cluster_uuid}
