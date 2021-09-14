ARG ALPINE_VERSION=3.13

FROM alpine:${ALPINE_VERSION}

ENV MKCERT_VERSION=1.4.3
ENV CAROOT="/certs"
ENV SERVER_HOSTNAMES="*.localhost.dev *.example.com"
ENV HOST_USER_ID 1000
ENV HOST_USER_NAME user

#ENV PATH="/usr/local/bin:${PATH}"
#ENV TRUST_STORES=""
#ENV JKS_PASSWORD="super-secret"

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

WORKDIR /certs

## Initialize container
COPY config/entrypoint.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

#CMD ["mkcert"]
