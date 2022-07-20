# docker-mkcert

Simple tool for making locally-trusted development certificates

Supported tags and respective `Dockerfile` links:
- [`1.4.3-1.1.0`](https://github.com/vavyskov/docker-mkcert/tree/master/1.4.3/alpine3.16)

Usage:

    docker run --rm -v $PWD:/root/.local/share/mkcert vavyskov/mkcert:1.4.3-1.1.0

    docker run --rm \
      -v $PWD:/certificates \
      -e CAROOT="/certificates" \
      -e MKCERT_HOSTNAMES="*.localhost.dev *.localhost.test *.example.com *.example.net \
          *.example.org *.example.edu project.corp project.domain project.example project.home \
          project.host project.invalid project.lan project.local project.localdomain" \
      -e HOST_USER_ID="1000" \
      -e HOST_USER_NAME="user" \
      vavyskov/mkcert:1.4.3-1.1.0

## Adding trusted root certificate authority
1. Operating system
   - **Linux (Debian)**:

         sudo cp rootCA.pem /usr/local/share/ca-certificates/
         sudo update-ca-certificates

2. Browsers:
   - **Chrome**: Settings -> Privacy and security -> Security -> Manage certificates -> Authorities -> Import (rootCA.pem)
