Need to setup service account and initialise API.

# Running

terraform apply --auto-approve

## Helm

Install with homebrew or whatever and

To get helm running with admin rights.

https://stackoverflow.com/questions/46672523/helm-list-cannot-list-configmaps-in-the-namespace-kube-system

```
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'      
helm init --service-account tiller --upgrade
```
## Install Consul with helm
```
git clone https://github.com/hashicorp/consul-helm
cd consul-helm
helm install ./
```

## Google Cloud Kubernetes

Change project: gcloud config set project kubernetes-consul-experiment
gcloud config set project kubernetes-consul-experiment

If you need to install:
gcloud components install kubectl

If you need to communicate with kubernetes api server:
kubectl proxy


Deploy container: 
kubectl run hello-server --image gcr.io/google-samples/hello-app:1.0 --port 8080

This will create load balancer and attach load balancer port 80 to your app port 8080.
kubectl expose deployment hello-server --type LoadBalancer \
  --port 80 --target-port 8080


