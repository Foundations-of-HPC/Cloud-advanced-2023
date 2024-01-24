RELEASE=jhub
NAMESPACE=jhub
helm repo add jupyterhub https://hub.jupyter.org/helm-chart/
helm repo update

helm install --dry-run $RELEASE jupyterhub/jupyterhub \
  --namespace  $NAMESPACE \
  --create-namespace \
  --values jhub_config.yaml >> dry_run.yaml
