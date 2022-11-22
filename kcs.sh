source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.

alias k=kubectl
alias kg='kubectl get'
alias kgp='kubectl get pod'
alias kc='kubectl create'
alias kd='kubectl delete'
alias kdes='kubectl describe'

complete -o default -F __start_kubectl k

 # pod (po), service (svc), replicationcontroller (rc), deployment (deploy), replicaset (rs)


# deploy a pod named nginx-pod using nginx:alpine image
k runn nginx-pod --image=nginx:alpine

k get pod 

# get pod info 
k describe pod <pod-name>

# deploying a pod with labels
k run <podname> --image=<image-name> --labels="<label>"
k run <podname> --image=<image-name> -n <namespace>

#deploy a namespace
 k create namespace <name of namespace>

 # list namespaces
 k get ns

# take a back up of etcd cluster and save it to /opt/etcd-backup.db 
ETCDCTL_API=3 etcdctl --endpoints $ENDPOINT snapshot save snapshotdb


cat /etc/kubernetes/manifest/etcd.yaml | grep file
view it to get the endpoint of listen-client
vi /etc/kubernetes/manifest/etcd.yaml

ETCDCTL_API=3 etcdctl --endpoints 127.0.0.1:2379 snapshot save /opt/etcd-backup.db \ --cacert=<file_path_trusted-ca> \ --cert=<cert_file_path> \ --key=<key_file_path>




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
k describe deploy <name_of_deployment>

# expose the web-app as service we-app-service on port 30082 on the node cluster. the app listens on port 8080
k get deploy
k expose deploy web-app --name=web-app-service --type NodePort --port 8080
# then we can edit the service and change the node port in the yaml
k edit svc web-app-service

# another way to do it
kubectl create service nodeport myservice --node-port=31000 --tcp=3050:80

# Use JSON PATH query to retries the osImages of all the nodes and store it in a file; osImages are in nodeInfo which are under status
k get nodes -o jsonpath='{.items[*].status.nodeInfo.osIamge}' > filename.txt

#create a persistant volume with the given parameters, name: pv-analytics, storage 100Mi, access modes: ReadwriteMany, Host path: /pv/data-analytics

vi pv.yaml

apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-analytics
spec:
  capacity:
    storage: 100Mi
  accessModes:
    - ReadWriteAny
  hostPath:
    path: /pv/data-analytics


k create -f pv.yaml

# get persistant volumes
k get pv

k describe pv pv-analytics









# create a static pod ; sometimes --dry-run=1 for it to be client
k run <pod name> --image=<image name> --dry-run=client -o yaml --command -- sleep 1000 > /etc/kubernetes/manifest/<pod-name>.yaml

#Use the explain function
k explain <output>


# list all pods in all namspaces
k get po --all-namespaces
k get po -n <namespace>






##
## troubleshooting
##

# Init: CrashLoopBackOff, it's the init container that is crashing
k describe pod <pod name>
kdes pod pod-name

#view logs of conatiner
k logs <pod-name> <container name>

# edit the pod
k edit pod <pod-name> 

k replace --force -f <new file from edit>

k get pods
