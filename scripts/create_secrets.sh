#!/bin/sh -xvf

# Update the data here - ESS logging cluster
logging_cloud_id=...
logging_cloud_auth=...

kubectl create namespace elastic-monitoring

# Delete old secrets
kubectl delete secret logging-cloud-secret --namespace=elastic-monitoring

# Retrieve cluster uuid
elastic_pwd=$(kubectl get secret observability-es-elastic-user -o=jsonpath='{.data.elastic}' -n elastic-monitoring | base64 --decode)
elastic_port=$(kubectl get services --namespace=elastic-monitoring observability-es-http -o=jsonpath='{.spec.ports[0].port}')

logging_cluster_uuid=$(kubectl exec --namespace=elastic-monitoring observability-es-default-0 -- curl -k --user "elastic:${elastic_pwd}" https://localhost:${elastic_port}/ 2> /dev/null | jq -r '.cluster_uuid')

# Monitoring cluster
kubectl create secret generic logging-cloud-secret --namespace=elastic-monitoring\
  --from-literal=cloud-id=${logging_cloud_id} \
  --from-literal=cloud-auth=${logging_cloud_auth} \
  --from-literal=cluster-uuid=${logging_cluster_uuid}
