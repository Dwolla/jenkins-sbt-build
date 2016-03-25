FROM java:8-jdk
MAINTAINER Dwolla Engineering <dev+docker@dwolla.com>

ENV HOME /home/jenkins

ADD jenkins-slave /usr/local/bin/jenkins-slave

RUN export JAVA_HOME=$(dirname $(dirname `realpath /etc/alternatives/java`)) && \
    sed -i s/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=60/ $JAVA_HOME/lib/security/java.security && \
    apt-get update && \
    apt-get install -y apt-transport-https ca-certificates && \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list && \
    echo "deb https://dl.bintray.com/sbt/debian /" > /etc/apt/sources.list.d/sbt.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 && \
    apt-get update && \
    apt-get install -y docker-engine sbt curl && \
    sbt version && \
    curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/2.53.2/remoting-2.53.2.jar && \
    chmod 755 /usr/share/jenkins && \
    chmod 644 /usr/share/jenkins/slave.jar && \
    useradd -c "Jenkins user" -d $HOME -m jenkins && \
    usermod -a -G docker jenkins && \
    chmod 755 /usr/local/bin/jenkins-slave

VOLUME /home/jenkins
WORKDIR /home/jenkins
USER jenkins

ENTRYPOINT ["jenkins-slave"]

