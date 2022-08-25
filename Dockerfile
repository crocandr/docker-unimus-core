FROM debian:bullseye

ENV DOWNLOAD_URL https://download.unimus.net/unimus-core/-%20Latest/Unimus-Core.jar

RUN apt-get update && apt-get install -y curl less wget tzdata

# copy all files into the container image
COPY files/* /opt/start.sh

# Unimus binary download
RUN curl -L -o /opt/unimus-core.jar $DOWNLOAD_URL
# check the downloaded file if checksum exists
RUN if [ -f /opt/checksum.signed ]; then echo "Checking checksum..."; sha1sum /opt/unimus-core.jar > /opt/checksum.new; sed -i "s@/opt/@@g" /opt/checksum.new; cat /opt/checksum*; diff -q /opt/checksum.new /opt/checksum.signed || { echo "Checksum invalid"; exit 1; }; fi

# JRE install
RUN apt-get install -y openjdk-11-jre-headless

#
# Start script permission
RUN chmod 755 /opt/start.sh
#
ENTRYPOINT /opt/start.sh
