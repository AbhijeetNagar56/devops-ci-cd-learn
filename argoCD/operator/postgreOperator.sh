
# clone repo
git clone https://github.com/zalando/postgres-operator.git
cd postgres-operator

# Apply manifests:
kubectl create -f manifests/configmap.yaml
kubectl create -f manifests/operator-service-account-rbac.yaml
kubectl create -f manifests/postgres-operator.yaml
kubectl create -f manifests/api-service.yaml

# Or use 

# Helm:
helm repo add postgres-operator-charts https://opensource.zalando.com/postgres-operator/charts/postgres-operator
helm install postgres-operator postgres-operator-charts/postgres-operator

# Verify operator pod:
kubectl get pods -l name=postgres-operator


# Apply it:
kubectl apply -f acid-minimal-cluster.yaml

# Check resources:
kubectl get pods
kubectl get postgresql
