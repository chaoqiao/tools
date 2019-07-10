microk8s.ctr -n k8s.io image ls | awk '{print $1"  "$4" "$5}' | grep -v sha256
