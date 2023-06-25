ARG BUILD_FROM=hassioaddons/base
FROM $BUILD_FROM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV LANG C.UTF-8



RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
    ca-certificates \
	g++ \
	gcc \
	curl \
	make \
	cargo \
	pkgconfig \
	jq && \
apk upgrade && \		
apk add --no-cache \
    libcrypto1.1=1.1.1u-r1 \ 
    libssl1.1=1.1.1u-r1 \
    python3 \
    python3-dev \
    py3-pip \
    build-base \
    libffi-dev \
    openssl-dev && \
	curl -proto '=https' -tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && source $HOME/.cargo/env && \
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
echo "**** install dependencies ****" && \
export CRYPTOGRAPHY_DONT_BUILD_RUST=1 && \
 pip install --upgrade pip setuptools wheel \
 pip install --no-cache-dir -U --no-binary :all: \
	cryptography==38.0.4 \
	cffi==1.15.1 \
	paho-mqtt==1.6.1 \
	pycparser==2.21 \
	PyYAML==6.0 && \
 rm -rf \
	/root/.cache \
	/tmp/*

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
