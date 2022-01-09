ARG ALPINE_VERSION="3.14"

FROM alpine:${ALPINE_VERSION}

ARG MKCERT_VERSION="1.4.3"

ENV CAROOT="/root/.local/share/mkcert"
ENV MKCERT_HOSTNAMES="*.localhost.dev *.localhost.test *.example.com *.example.net *.example.org *.example.edu project.corp project.domain project.example project.home project.host project.invalid project.lan project.local project.localdomain"
ENV MKCERT_FILE_NAME="example.com"
ENV HOST_USER_ID="${UNSET}"
ENV HOST_USER_NAME="${UNSET}"

RUN echo "mkcert" \
&&  apk add --no-cache --virtual .build-deps \
        curl \
#        git \
&&  curl -L https://github.com/FiloSottile/mkcert/releases/download/v${MKCERT_VERSION}/mkcert-v${MKCERT_VERSION}-linux-amd64 -o /usr/local/bin/mkcert \
&&  chmod +x /usr/local/bin/mkcert \
&&  apk del --purge .build-deps

RUN echo "System tools" \
&&  apk add --no-cache \
        ## Users
        shadow

WORKDIR ${CAROOT}

## Initialize container
COPY config/entrypoint.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

#CMD ["mkcert"]
