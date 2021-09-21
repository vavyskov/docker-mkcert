# docker-mkcert

Simple tool for making locally-trusted development certificates

Supported tags and respective `Dockerfile` links:
- [`1.4.3-alpine3.13`](https://github.com/vavyskov/docker-mkcert/tree/master/1.4.3/alpine3.13)

Usage:

    docker run --rm -v $PWD:/root/.local/share/mkcert -it vavyskov/mkcert:1.4.3-alpine3.13

    docker run --rm \
      -v $PWD:/certs \
      -e CAROOT="/certs" \
      -e SERVER_HOSTNAMES="*.corp *.domain *.example *.home *.host *.invalid *.lan *.local *.localdomain *.example.com *.example.net *.example.org *.example.edu" \
      -e HOST_USER_ID="1000" \
      -e HOST_USER_NAME="user" \
      -it vavyskov/mkcert:1.4.3-alpine3.13
