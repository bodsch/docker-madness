docker-markdown-service
=======================

a small docker container they provide a markdown render service.

sinatra based

# Status

[![Docker Pulls](https://img.shields.io/docker/pulls/bodsch/docker-markdown-service)][hub]
[![Image Size](https://images.microbadger.com/badges/image/bodsch/docker-markdown-service)][microbadger]
[![Build Status](https://travis-ci.org/bodsch/docker-markdown-service)][travis]

[hub]: https://hub.docker.com/r/bodsch/docker-markdown-service
[microbadger]: https://microbadger.com/images/bodsch/docker-markdown-service
[travis]: https://travis-ci.org/bodsch/docker-markdown-service

# supported Environment Variables

- `PUBLIC_FOLDER` (default: `/var/www`)
- `PORTS` (default: `8080`)
- `BIND_TO` (default: `0.0.0.0`)
- `STYLESHEET` (default: `style.css`)


# Ports

- `8080`: Web-Server
