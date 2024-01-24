RELEASE=jhub
NAMESPACE=jhub
helm repo add jupyterhub https://hub.jupyter.org/helm-chart/
helm repo update

helm install $RELEASE jupyterhub/jupyterhub \
  --namespace  $NAMESPACE \
  --create-namespace \
  --values jhub_config.yaml 
