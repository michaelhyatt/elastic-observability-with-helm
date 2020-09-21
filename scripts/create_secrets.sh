#!/bin/sh -xvf

kubectl create namespace elastic-monitoring

# Delete old secrets
kubectl delete secret logging-cloud-secret --namespace=elastic-monitoring

# Retrieve cluster uuid
elastic_pwd=$(kubectl get secret observability-es-elastic-user -o=jsonpath='{.data.elastic}' -n elastic-monitoring | base64 --decode)
elastic_ip=$(kubectl get services --namespace=elastic-monitoring observability-es-http -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
elastic_port=$(kubectl get services --namespace=elastic-monitoring observability-es-http -o=jsonpath='{.spec.ports[0].port}')

logging_cloud_id=$(curl -k --user elastic:${elastic_pwd} https://${elastic_ip}:${elastic_port} 2> /dev/null | jq -r '.cluster_uuid')

# logging cluster
logging_cloud_id=...
logging_cloud_auth=...

# Monitoring cluster
kubectl create secret generic logging-cloud-secret --namespace=elastic-monitoring\
  --from-literal=cloud-id=${logging_cloud_id} \
  --from-literal=cloud-auth=${logging_cloud_auth} \
  --from-literal=cluster-uuid=${logging_cluster_uuid}
