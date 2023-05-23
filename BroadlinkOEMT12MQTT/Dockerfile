ARG BUILD_FROM=hassioaddons/base
FROM $BUILD_FROM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV LANG C.UTF-8

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	g++ \
	gcc \
	curl \
	make \
	jq && \
apk add --update \
    python3 \
    python3-dev \
    py3-pip \
    build-base && \
 echo "**** install pip packages ****" && \
 pip install --upgrade pip \
 pip install --no-cache-dir -U \
	paho-mqtt \
	pyyaml \
	pycrypto && \
 echo "**** Install app ****" && \
 mkdir -p /app/ac2mqtt && \
 echo "Created App folder in /app/ac2mqtt" && \
 mkdir -p /config && \
 echo "Created config folder in /config" && \
 curl -o \
 /tmp/ac2mqtt.tar.gz -L \
	"https://github.com/liaan/broadlink_ac_mqtt/archive/refs/tags/1.2.1.tar.gz" && \
 echo "Downloaded successfully, extracting to /app/ac2mqtt" && \
 tar xf \
 /tmp/ac2mqtt.tar.gz -C \
	/app/ac2mqtt --strip-components=1 && \
cd /app/ac2mqtt && pip install -r requirements.txt && \
 rm -rf \
	/root/.cache \
	/tmp/*

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
