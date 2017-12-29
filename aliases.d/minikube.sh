alias minikube-time-sync='minikube ssh -- docker run -i --rm --privileged --pid=host debian nsenter -t 1 -m -u -n -i date -u $(date -u +%m%d%H%M%Y)'
alias minikube-proxy='minikube-init && kubectl --context minikube proxy'

minikube-init() {
    if [[ $# -ne 1 ]]; then
        echo "usage: minikube-init KUBERNETES_VERSION" >&2
        return 1
    fi
    local version=$1; shift
    command minikube status | grep -q 'minikube: Running'
    if [[ $? -ne 0 ]]; then
        command minikube start --vm-driver hyperkit --kubernetes-version "${version}"
        #--extra-config=apiserver.Authorization.Mode=RBAC
    fi
    command minikube addons enable ingress
    eval $(command minikube docker-env)
    env | grep 'DOCKER\w\+'
    command minikube status
    kubectl config use-context minikube

    if command -v helm >/dev/null; then
        helm --kube-context minikube init --upgrade
    fi
}

minikube() {
    if [ $# -eq 1 ]; then
        case "$1" in
            start) minikube start8; return $? ;;
            start7) minikube-init "v1.7.5" ; return $? ;;
            start8) minikube-init "v1.8.0" ; return $? ;;
            proxy) minikube proxy8; return $? ;;
            proxy7) minikube start7 && kubectl --context minikube proxy ; return $? ;;
            proxy8) minikube start8 && kubectl --context minikube proxy ; return $? ;;
        esac
    fi

    command minikube $@
}
