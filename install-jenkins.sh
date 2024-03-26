#!/bin/bash

#jenkins
sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install -y jenkins
sudo yum list | grep java-17
sudo yum install -y java-17-amazon-corretto-devel.x86_64
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo yum install -y git 
sudo yum install -y maven

#docker
sudo yum install -y docker 
sudo systemctl enable docker
sudo usermod -aG docker jenkins 
sudo systemctl start docker
docker run -d -p 9000:9000 sonarqube:lts-community

#trivy
wget https://github.com/aquasecurity/trivy/releases/download/v0.19.2/trivy_0.19.2_Linux-64bit.tar.gz
tar -xvf trivy_0.19.2_Linux-64bit.tar.gz
sudo mv trivy /usr/local/bin/

