FROM debian:buster

ENV DOWNLOAD_URL https://download.unimus.net/unimus-core/-%20Latest/Unimus-Core.jar

RUN apt-get update && apt-get install -y curl vim less wget tzdata

#
# Unimus
RUN curl -L -o /opt/unimus-core.jar $DOWNLOAD_URL

# JDK install and check
RUN apt-get install -y openjdk-11-jdk-headless && \
    jarsigner -verify /opt/unimus-core.jar | grep -i "jar verified" || { echo "Unimus Core binary is not verified"; exit 1; } && \
    apt-get purge -y openjdk-11-jdk-headless
# JRE install
RUN apt-get install -y openjdk-11-jre-headless

#
# Start script
COPY files/start.sh /opt/start.sh
RUN chmod 755 /opt/start.sh
#
ENTRYPOINT /opt/start.sh
