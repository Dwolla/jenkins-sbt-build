FROM java:8-jdk
MAINTAINER Dwolla Engineering <dev+docker@dwolla.com>

ENV HOME /home/jenkins

COPY jenkins-slave /usr/local/bin/jenkins-slave
COPY setup.sh /setup.sh

RUN chmod 755 /setup.sh && sync && /setup.sh && rm -f /setup.sh

VOLUME /home/jenkins
WORKDIR /home/jenkins
USER jenkins

ENTRYPOINT ["jenkins-slave"]

