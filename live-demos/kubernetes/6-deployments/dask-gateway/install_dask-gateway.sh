helm repo add dask https://helm.dask.org/
helm repo update

RELEASE=dask-gateway
NAMESPACE=jhub

helm upgrade  \
    --install \
    --repo=https://helm.dask.org \
    --namespace $NAMESPACE \
    --values dask-gateway_config.yaml \
    $RELEASE \
    dask-gateway \

