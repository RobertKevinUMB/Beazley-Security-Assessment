
#!/bin/bash
apt-get update
apt-get install -y docker.io apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet=1.28.2-00 kubeadm=1.28.2-00
systemctl enable docker kubelet

# Join cluster
until scp -o StrictHostKeyChecking=no ubuntu@${master_ip}:/join-command.sh ./join-command.sh
do
  echo "Waiting for master node to be ready..."
  sleep 10
done

chmod +x join-command.sh
./join-command.sh

