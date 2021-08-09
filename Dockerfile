FROM debian:buster

ENV DOWNLOAD_URL https://download.unimus.net/unimus-core-dev/Unimus-Core.jar 

RUN apt-get update && apt-get install -y curl vim less wget tzdata

# OpenJDK
RUN apt-get install -y openjdk-11-jdk-headless
#
# Unimus 
RUN curl -L -o /opt/unimus-core.jar $DOWNLOAD_URL
#
VOLUME /etc/unimus-core

# Start script
COPY files/start.sh /opt/start.sh
RUN chmod 755 /opt/start.sh
#
ENTRYPOINT /opt/start.sh

