#!/bin/bash
# Applying the RBAC
kubectl apply -f ../K8s/manifests/
# Bootstrapping helm
helm init --service-account tiller --tiller-namespace prod --upgrade
helm init --service-account tiller --tiller-namespace dev --upgrade
helm init --service-account tiller --tiller-namespace devops --upgrade
# Adding helm repo and updating
helm repo add jjjje https://raw.githubusercontent.com/jerry619/helmcharts/master
helm repo update
# Generating Kubeconfig specially to be used in Jenkins with restricted access
sh kubeconfig.sh
