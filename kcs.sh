source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.

alias k=kubectl
alias kg='kubectl get'
alias kgp='kubectl get pod'
alias kc='kubectl create'
alias kd='kubectl delete'
alias kdes='kubectl describe'

complete -o default -F __start_kubectl k

 pod (po), service (svc), replicationcontroller (rc), deployment (deploy),
replicaset (rs)


# deploy a pod named nginx-pod using nginx:alpine image
k runn nginx-pod --image=nginx:alpine

k get pod 

# get pod info 
k describe pod <pod-name>

# deploying a pod with labels
k run <podname> --image=<image-name> --labels="<label>"

#deploy a namespace
 k create namespace <name of namespace>

 # list namespaces
 k get ns

# get a lis of nodes and store it in a file
k get nodes -o json > <file_path>

#create a service <service_name> to expose port 6379 on the messaging application
k expose --help
k expose rc nginx --port=80 --target-port=8000
k expose pod meessaging --port 6379 --name messaging-service

# check service
k get svc
k describe svc messaging-service
k get pods 

# detailed view of pods with ip address
k get po -o wide

#create a deployment named hr-web-app
k create deployment <name_of_deployment> --image=kodekloud/webapp-color --replicas=2

# get deployment status
k describe