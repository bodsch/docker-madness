
FROM alpine:3.6

MAINTAINER Bodo Schulz <bodo@boone-schulz.de>

ENV \
  TERM=xterm \
  BUILD_DATE="2017-11-28"

EXPOSE 2222

LABEL \
  version="1711" \
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
  apk update --no-cache && \
  apk upgrade --no-cache && \
  apk add --quiet --no-cache --virtual .build-deps \
    build-base \
    git \
    ruby-dev \
    zlib-dev && \
  apk add --no-cache \
    ruby-io-console \
    ruby-rdoc && \
  cd /srv && \
  git clone https://github.com/bodsch/ruby-markdown-service && \
  gem install --no-rdoc --no-ri \
    sinatra \
    redcarpet && \
  apk del --quiet .build-deps && \
  rm -rf \
    /srv/ruby-markdown-service/.git \
    /tmp/* \
    /var/cache/apk/*

COPY rootfs /

WORKDIR /var/www

VOLUME /var/www

HEALTHCHECK \
  --interval=5s \
  --timeout=2s \
  --retries=12 \
  CMD curl --silent --fail http://localhost:2222/health || exit 1

ENTRYPOINT [ "/srv/ruby-markdown-service/bin/markdown.rb" ]
