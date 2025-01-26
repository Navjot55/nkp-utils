export NKP_VERSION=2.12.1                                       # NKP version to install
export CLUSTER_NAME=cluster-5                                   # NKP cluster name. When using NKP Pro/Ultimate, this name is used to generate the license key
export NUTANIX_USER=admin                                       # Prism Central username
export NUTANIX_PASSWORD='nx2Tech672!'                           # Keep the password enclosed between single quotes - Ex: 'password'
export NUTANIX_ENDPOINT=10.38.1.10                           # Prism Central IP address
export NUTANIX_PORT=9440                                        # Prism Central port (default: 9440)
export LB_IP_RANGE=10.38.1.18-10.38.1.20                                            # Load balancer IP range - Ex: 10.42.236.204-10.42.236.204
export CONTROL_PLANE_ENDPOINT_IP=10.38.1.17                               # Kubernetes VIP. Must be in the same subnet as the VMs - Ex: 10.42.236.203
export NUTANIX_MACHINE_TEMPLATE_IMAGE_NAME=nkp-rocky-9.4-release-1.29.9-20241008013213.qcow2 # Update with the NKP Rocky image name
export NUTANIX_PRISM_ELEMENT_CLUSTER_NAME=PHX-SPOC001-1                      # Prism Element cluster name - Ex: PHX-POC207
export NUTANIX_SUBNET_NAME=primary                                     # Ex: primary
export NUTANIX_STORAGE_CONTAINER_NAME=default      # Change to your preferred Prism storage container
export REGISTRY_MIRROR_URL=registry.nutanixdemo.com/docker.io   # Required on Nutanix HPOC
export current_dir=$(pwd)

nkp create cluster nutanix --cluster-name $CLUSTER_NAME \
    --endpoint https://$NUTANIX_ENDPOINT:$NUTANIX_PORT \
    --insecure \
    --kubernetes-service-load-balancer-ip-range $LB_IP_RANGE \
    --kubernetes-version 1.29.9 \
    --control-plane-endpoint-ip $CONTROL_PLANE_ENDPOINT_IP \
    --control-plane-vm-image $NUTANIX_MACHINE_TEMPLATE_IMAGE_NAME \
    --control-plane-prism-element-cluster $NUTANIX_PRISM_ELEMENT_CLUSTER_NAME \
    --control-plane-subnets $NUTANIX_SUBNET_NAME \
    --control-plane-replicas 1 \
    --worker-vm-image $NUTANIX_MACHINE_TEMPLATE_IMAGE_NAME \
    --worker-prism-element-cluster $NUTANIX_PRISM_ELEMENT_CLUSTER_NAME \
    --worker-subnets $NUTANIX_SUBNET_NAME \
    --worker-replicas 2 \
    --csi-storage-container $NUTANIX_STORAGE_CONTAINER_NAME \
    --registry-mirror-url http://$REGISTRY_MIRROR_URL \
    --namespace nav-workspace-8rnws \
    --output yaml \
    --dry-run \
> ${CLUSTER_NAME}.yaml