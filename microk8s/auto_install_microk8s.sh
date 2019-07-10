#!/bin/bash
# ubuntu microk8s install script
# first install docker then pull images
apt-get update && sudo apt-get install -y snapd
snap install microk8s --classic --channel=1.15/stable
microk8s.enable dns dashboard

docker pull chaoqiao/kubernetes-dashboard-amd64:v1.10.1
docker pull chaoqiao/heapster-amd64:v1.5.2
docker pull chaoqiao/k8s-pause:3.1
docker pull chaoqiao/k8s-dns-sidecar-amd64:1.14.7
docker pull chaoqiao/k8s-dns-kube-dns-amd64:1.14.7
docker pull chaoqiao/k8s-dns-dnsmasq-nanny-amd64:1.14.7 
docker pull chaoqiao/heapster-influxdb-amd64:v1.3.3
docker pull chaoqiao/heapster-grafana-amd64:v4.4.3

docker tag chaoqiao/kubernetes-dashboard-amd64:v1.10.1 k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.1
docker tag chaoqiao/heapster-amd64:v1.5.2 k8s.gcr.io/heapster-amd64:v1.5.2
docker tag chaoqiao/k8s-pause:3.1 k8s.gcr.io/pause:3.1
docker tag chaoqiao/k8s-dns-sidecar-amd64:1.14.7 gcr.io/google_containers/k8s-dns-sidecar-amd64:1.14.7
docker tag chaoqiao/k8s-dns-kube-dns-amd64:1.14.7 gcr.io/google_containers/k8s-dns-kube-dns-amd64:1.14.7
docker tag chaoqiao/k8s-dns-dnsmasq-nanny-amd64:1.14.7 gcr.io/google_containers/k8s-dns-dnsmasq-nanny-amd64:1.14.7
docker tag chaoqiao/heapster-influxdb-amd64:v1.3.3 k8s.gcr.io/heapster-influxdb-amd64:v1.3.3
docker tag chaoqiao/heapster-grafana-amd64:v4.4.3 k8s.gcr.io/heapster-grafana-amd64:v4.4.3

docker save k8s.gcr.io/pause > pause.tar
docker save k8s.gcr.io/heapster-influxdb-amd64 > heapster-influxdb-amd64.tar
docker save k8s.gcr.io/heapster-grafana-amd64 > heapster-grafana-amd64.tar
docker save k8s.gcr.io/kubernetes-dashboard-amd64 > kubernetes-dashboard-amd64.tar
docker save k8s.gcr.io/heapster-amd64 > heapster-amd64.tar
docker save gcr.io/google_containers/k8s-dns-dnsmasq-nanny-amd64 > k8s-dns-dnsmasq-nanny-amd64.tar
docker save gcr.io/google_containers/k8s-dns-kube-dns-amd64 > k8s-dns-kube-dns-amd64.tar
docker save gcr.io/google_containers/k8s-dns-sidecar-amd64 > k8s-dns-sidecar-amd64.tar

microk8s.ctr -n k8s.io image import pause.tar
microk8s.ctr -n k8s.io image import heapster-influxdb-amd64.tar
microk8s.ctr -n k8s.io image import heapster-grafana-amd64.tar
microk8s.ctr -n k8s.io image import kubernetes-dashboard-amd64.tar
microk8s.ctr -n k8s.io image import heapster-amd64.tar
microk8s.ctr -n k8s.io image import k8s-dns-dnsmasq-nanny-amd64.tar
microk8s.ctr -n k8s.io image import k8s-dns-kube-dns-amd64.tar
microk8s.ctr -n k8s.io image import k8s-dns-sidecar-amd64.tar

