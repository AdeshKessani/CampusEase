#!/bin/bash

CURRENT_USER_ID=$(id -u)
CURRENT_TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_FILE_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE_PATH=/tmp/$SCRIPT_FILE_NAME-$CURRENT_TIMESTAMP.log
RED_COLOR="\e[31m"
GREEN_COLOR="\e[32m"
YELLOW_COLOR="\e[33m"
NO_COLOR="\e[0m"

function validate_status(){
    if [ $1 -ne 0 ]; then
        echo -e "$2...$RED_COLOR FAILURE $NO_COLOR"
        exit 1
    else
        echo -e "$2...$GREEN_COLOR SUCCESS $NO_COLOR"
    fi
}

if [ $CURRENT_USER_ID -ne 0 ]; then
    echo "This script must be run with root privileges."
    exit 1
else
    echo "Root privileges confirmed."
fi

# Docker installation and setup
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user
validate_status $? "Docker installation"

# eksctl installation
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/local/bin
eksctl version
validate_status $? "eksctl installation"

# kubectl installation
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.0/2024-05-12/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv kubectl /usr/local/bin/kubectl
validate_status $? "kubectl installation"

# Helm installation
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
validate_status $? "helm installation"

# MySQL client installation
dnf install mysql -y
validate_status $? "MySQL installation"

# Kubens installation
git clone https://github.com/ahmetb/kubectx /opt/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens
validate_status $? "kubens installation"
