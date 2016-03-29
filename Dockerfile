FROM java:8-jdk
MAINTAINER Dwolla Engineering <dev+docker@dwolla.com>

ENV HOME /home/jenkins

COPY jenkins-slave /usr/local/bin/jenkins-slave
COPY setup.sh /setup.sh

RUN chmod 755 /setup.sh && sync && /setup.sh && rm -f /setup.sh

WORKDIR /home/jenkins
USER jenkins

# Pre-download some sbt versions because it's fairly slow at runtime
RUN mkdir -p /tmp/sbt/project; \
    cd /tmp/sbt; \
    for v in 0.13.5 0.13.7 0.13.8 0.13.9 0.13.11; do \
      echo sbt.version=$v > project/build.properties; \
      sbt version; \
    done; \
    rm -rf /tmp/sbt

ENTRYPOINT ["jenkins-slave"]

