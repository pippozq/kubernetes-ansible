# Kubernetes-ansible
1. Install etcd,flannel,kubernets by Ansible
2. Using Redhad epel yum source
3. Kubernets Version is not the lastest (latest version is **1.9**, version in epel is just **1.5**)

## Install Etcd
1. Update the etcd host in hosts/hosts file (for now, do not support cluster)
```
[etcd]
172.16.251.60 # this is the etcd host
```

2. Update the "etcd_prefix" in vars/etcd.yml

```
---
#etcd args
etcd_config_path: '/etc/etcd/'
etcd_prefix: '/k8s/network' #  prefix which flannel will use
```

```
# By default, using the ssh public key, so you can use
ansible-playbook -i hosts/hosts etcd.yml 
# Using password
ansible-playbook -i hosts/hosts etcd.yml --ask-pass

```

## Install Kubernets Master
1. Update the kube_master host in hosts/hosts file (for now, do not support cluster)
```
[kube_master]
172.16.251.60 # your master host

```

2. Update the  vars/redhat_kube_master.yml

```
---

kubernets_master_install_list:
    - "epel-release"
    - "kubernetes"
    - "flannel"

kubernets_config_file_list:
  - 'apiserver'
  - 'config'
  - 'kubelet'
  - 'proxy'

#common args
sys_config_path: '/etc/sysconfig'


#kube args
kube_config_path: '/etc/kubernetes'
kube_master: '172.16.251.60:8080' # your master ip or domain

#kube service
kubernets_services:
    - "kube-apiserver"
    - "kube-controller-manager"
    - "kube-proxy"
    - "kube-scheduler"
    - 'kubelet'
    - 'kube-proxy'

#docker registry
docker_registry: '172.16.251.35:5000' # your private docker registry

#flannel args
etcd_endpoint: 172.16.251.60:2379 # etcd endpoint
etcd_prefix: '/k8s/network' # must be same as vars/etcd.yml
eth: 'eth0' # your eth name

```

```
# By default, using the ssh public key, so you can use
ansible-playbook -i hosts/hosts kube_master.yml 
# Using password
ansible-playbook -i hosts/hosts kube_master.yml --ask-pass

```


## Install Kubernets Node
1. Update the kube_node host in hosts/hosts file
```
[kube_node]
172.16.251.61
172.16.251.62

```

2. Update the  vars/redhat_kube_node.yml

```
---

kubernets_node_install_list:
    - "epel-release"
    - "kubernetes-node"
    - "flannel"

kubernets_config_file_list:
  - 'config'
  - 'kubelet'
  - 'proxy'

#common args
sys_config_path: '/etc/sysconfig'


#kube args
kube_config_path: '/etc/kubernetes'
kube_master: '172.16.251.60:8080' # your master ip or domain

#docker registry
docker_registry: '172.16.251.35:5000' # your private docker registry

#flannel args
etcd_endpoint: 172.16.251.60:2379 # etcd endpoint
etcd_prefix: '/k8s/network' # must be same as vars/etcd.yml
eth: 'eth0' # your eth name


```

```
# By default, using the ssh public key, so you can use
ansible-playbook -i hosts/hosts kube_node.yml 
# Using password
ansible-playbook -i hosts/hosts kube_node.yml --ask-pass

```

## License
source code is licensed under the Apache Licence, Version 2.0 (http://www.apache.org/licenses/LICENSE-2.0.html).
