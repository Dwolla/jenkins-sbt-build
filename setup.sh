#!/bin/sh

# Disable DNS caching in Java security
export JAVA_HOME=$(dirname $(dirname `realpath /etc/alternatives/java`))
sed -i s/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=60/ $JAVA_HOME/lib/security/java.security

# Install HTTPS apt transport
apt-get update
apt-get install -y apt-transport-https ca-certificates

# Set up Docker apt repository
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list

# Set up sbt apt repository
echo "deb https://dl.bintray.com/sbt/debian /" > /etc/apt/sources.list.d/sbt.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823

# Install dependencies
apt-get update
apt-get install -y docker-engine=1.9.1-0~jessie sbt curl
sbt version

# Install Jenkins jars
curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/2.56/remoting-2.56.jar
chmod 755 /usr/share/jenkins
chmod 644 /usr/share/jenkins/slave.jar

useradd -c "Jenkins user" -d $HOME -m jenkins
usermod -a -G docker jenkins
chmod 755 /usr/local/bin/jenkins-slave

