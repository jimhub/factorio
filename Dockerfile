FROM ubuntu:latest

MAINTAINER jliljenq <jliljenq@gmail.com>

ENV FACTORIO_VERSION 0.12.26
ENV SERVER_OPTS --disallow-commands --autosave-interval 20
ENV MAP_FILE defaultMap.zip

ADD config.ini /factorio/config.ini
ADD entrypoint.sh /factorio/entrypoint.sh

WORKDIR /factorio

RUN apt-get update &&\
  apt-get install -y curl && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  curl -L -k https://www.factorio.com/get-download/$FACTORIO_VERSION/headless/linux64 | tar --strip-components=1 -xzf -

VOLUME ["/factorio/saves", "/factorio/config"]

EXPOSE 34197/udp
ENTRYPOINT ["bash", "entrypoint.sh"]
