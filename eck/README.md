# Starting Elastic Cloud on Kubernetes

## Deploy the operator
```
% kubectl apply -f https://download.elastic.co/downloads/eck/1.2.1/all-in-one.yaml
```

## Elastic cluster deployment
### Deploy trial license
```
% kubectl apply -f eck/eck_trial_license.yml
secret/eck-trial-license created
```

### Deploy elasticsearch
```
% kubectl apply -f eck/elasticsearch.yml
elasticsearch.elasticsearch.k8s.elastic.co/observability created
```

### Check elasticsearch is running
```
% kubectl get elasticsearch -n elastic-monitoring
NAME         HEALTH   NODES   VERSION   PHASE   AGE
observability   green    3       7.8.0     Ready   4m31s

% kubectl get service observability-es-http -n elastic-monitoring
NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
observability-es-http   ClusterIP   10.23.86.20   <none>        9200/TCP   5m2s
```

### Deploy kibana
```
% kubectl apply -f eck/kibana.yml
```

### Check kibana is running
```
% kubectl get kibana -n elastic-monitoring
NAME         HEALTH   NODES   VERSION   AGE
observability   green    1       7.8.0     2m18s

% kubectl get service observability-kb-http -n elastic-monitoring
NAME                 TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)          AGE
observability-kb-http   LoadBalancer   10.33.66.107   35.121.12.172   5601:32401/TCP   9m46s
```

### Get elastic user password
```
% kubectl get secret observability-es-elastic-user -o=jsonpath='{.data.elastic}' -n elastic-monitoring | base64 --decode; echo
```

### Get the services and their IP addresses. Needed for Kibana
```
% kubectl get services -n elastic-monitoring
```

* Connect to Kibana by it's IP address and use the generated `elastic` password

### Create secrets for subsequent deployments
```
% ../install/create_eck_secrets.sh
```
