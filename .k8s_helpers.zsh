#!/bin/bash

# k logs -f with FZF
function kl {
  local namespace
  namespace=$(
    kubectl get ns | \
    sed 1d | \
    awk '{print $1}' | \
    fzf --header-first --header $'Namespaces\n\n' --layout=reverse --border
  )
  local pod
  pod=$(
    kubectl get pods -n $namespace | \
    sed 1d | \
    awk '{print $1}' | \
    fzf --header-first --header $'Pods\n\n' --layout=reverse --border
  )
  echo "Showing logs for $pod"

  kubectl logs -f -n $namespace $pod
}

# k exec -it pod with FZF
function kx {
  local namespace
  namespace=$(
    kubectl get ns | \
    sed 1d | \
    awk '{print $1}' | \
    fzf --header-first --header $'Namespaces\n\n' --layout=reverse --border
  )

  local pod
  pod=$(
    kubectl get pods -n $namespace | \
    sed 1d | \
    awk '{print $1}' | \
    fzf --header-first --header $'Pods\n\n' --layout=reverse --border
  )

  echo "Connecting to $pod"

  if [ -z $1 ]
  then
    kubectl exec -it $pod -n $namespace -- /bin/bash
  else
    kubectl exec -it $pod -n $namespace -- $1
  fi
}

# k port-forward with FZF
function kproxy {
  local namespace
  namespace=$(
    kubectl get ns | \
    sed 1d | \
    awk '{print $1}' | \
    fzf --header-first --header $'Namespaces\n\n' --layout=reverse --border
  )

  local pod
  pod=$(
    kubectl get pods -n $namespace | \
    sed 1d | \
    awk '{print $1}' | \
    fzf --header-first --header $'Pods\n\n' --layout=reverse --border
  )

  local port_mapping
  echo "Enter port mapping using the form local_port:pod_port"
  read port_mapping
  echo "Setting up proxy to $pod on $port_mapping..."

  kubectl port-forward -n $namespace $pod $port_mapping
}
