alias minikube-time-sync='minikube ssh -- docker run -i --rm --privileged --pid=host debian nsenter -t 1 -m -u -n -i date -u $(date -u +%m%d%H%M%Y)'

minikube-init() {
    minikube status | grep -q 'minikube: Running'
    if [[ $? -ne 0 ]]; then
        minikube start --vm-driver xhyve --kubernetes-version 'v1.8.0'
        #--extra-config=apiserver.Authorization.Mode=RBAC
    fi
    minikube addons enable ingress
    eval $(minikube docker-env)
    env | grep 'DOCKER\w\+'
    minikube status
    kubectl config use-context minikube
}
