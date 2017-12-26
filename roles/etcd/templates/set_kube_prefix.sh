#!/bin/bash
etcdctl set {{etcd_prefix}}/config '{ "Network": "10.0.0.0/8","SubnetLen": 20,"SubnetMin": "10.10.0.0","SubnetMax": "10.99.0.0","Backend": {"Type": "vxlan","Port": 7890}}'
