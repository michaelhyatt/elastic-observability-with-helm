#!/bin/sh -vx

alias k="kubectl -n elastic-monitoring"
alias kgp="k get pods"
alias kgps="kubectl get pods --namespace=kube-system"
alias kd="k delete -f"
alias kds="kubectl delete --namespace=kube-system -f"
alias kc="k create -f"
alias kcs="kubectl create --namespace=kube-system -f"
