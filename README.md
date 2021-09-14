# docker-mkcert

Simple tool for making locally-trusted development certificates

Supported tags and respective `Dockerfile` links:
- [`1.4.3-alpine3.13`](https://github.com/vavyskov/docker-mkcert/tree/master/1.4.3/alpine3.13)

Usage:

    docker run --rm -v $PWD:/certs -e SERVER_HOSTNAMES="*.localhost.dev *.example.com" -it vavyskov/mkcert:1.4.3-alpine3.13
