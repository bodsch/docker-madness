FROM alpine:latest

MAINTAINER Bodo Schulz <bodo@boone-schulz.de>

LABEL version="1703-02"

ENV \
  ALPINE_MIRROR="dl-cdn.alpinelinux.org" \
  ALPINE_VERSION="v3.5" \
  TERM=xterm

EXPOSE 2222

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

CMD [ "/bin/sh" ]

# ENTRYPOINT [ "/usr/bin/madness" ]
