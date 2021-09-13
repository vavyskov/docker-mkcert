ARG ALPINE_VERSION=3.13

FROM alpine:${ALPINE_VERSION}

ENV MKCERT_VERSION=1.4.3

RUN echo "mkcert" \
&&  apk add --no-cache --virtual .build-deps \
        curl \
#        git \
&&  curl -L https://github.com/FiloSottile/mkcert/releases/download/v${MKCERT_VERSION}/mkcert-v${MKCERT_VERSION}-linux-amd64 -o /usr/local/bin/mkcert \
&&  chmod +x /usr/local/bin/mkcert \
&&  apk del --purge .build-deps

CMD ["mkcert"]
