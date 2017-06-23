
FROM alpine:3.6

MAINTAINER Bodo Schulz <bodo@boone-schulz.de>

ENV \
  ALPINE_MIRROR="mirror1.hs-esslingen.de/pub/Mirrors" \
  ALPINE_VERSION="v3.6" \
  TERM=xterm

EXPOSE 2222

LABEL \
  version="1706-04.1" \
  org.label-schema.build-date=${BUILD_DATE} \
  org.label-schema.name="Markdown Service" \
  org.label-schema.description="Docker Image for an markdown Server" \
  org.label-schema.url="https://github.com/bodsch/ruby-markdown-service" \
  org.label-schema.vcs-url="https://github.com/bodsch/docker-markdown-service" \
  org.label-schema.vendor="Bodo Schulz" \
  org.label-schema.version="1.0" \
  org.label-schema.schema-version="1.0" \
  com.microscaling.docker.dockerfile="/Dockerfile" \
  com.microscaling.license="unlicense"

# ---------------------------------------------------------------------------------------

RUN \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/main"       > /etc/apk/repositories && \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/community" >> /etc/apk/repositories && \
  apk --quiet --no-cache update && \
  apk --quiet --no-cache upgrade && \
  apk --quiet --no-cache add \
    build-base \
    drill \
    git \
    ruby-io-console \
    ruby-rdoc \
    ruby-dev \
    zlib-dev && \
  cd /srv && \
  git clone https://github.com/bodsch/ruby-markdown-service && \
  gem install --no-rdoc --no-ri \
    sinatra \
    redcarpet && \
  apk del --purge \
    build-base \
    git \
    ruby-dev \
    zlib-dev && \
  rm -rf /var/cache/apk/*

COPY rootfs /

WORKDIR "/var/www"


ENTRYPOINT [ "/srv/ruby-markdown-service/bin/markdown.rb" ]
