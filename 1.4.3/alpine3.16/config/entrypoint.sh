#!/bin/sh

if [ -z "$CAROOT" ]; then
  echo "CAROOT environment variable not defined. Please set CAROOT to the desired directory."
  exit 1
fi

if [ -z "$MKCERT_HOSTNAMES" ]; then
  echo "MKCERT_HOSTNAMES environment variable not defined. Please set MKCERT_HOSTNAMES to the desired hostnames (each hostname being separated by a space)."
  exit 1
fi

set -e # Exit immediately if a command exits with a non-zero status.

## IF $CAROOT has not certificates (hidden files are enabled)
if [ $(ls $CAROOT | wc -l) = 0 ]; then
  ## $MKCERT_HOSTNAMES without quotes
  mkcert -cert-file "$CAROOT/$MKCERT_FILE_NAME.crt" -key-file "$CAROOT/$MKCERT_FILE_NAME.key" $MKCERT_HOSTNAMES
  mkcert -pkcs12 -p12-file "$CAROOT/$MKCERT_FILE_NAME.p12" $MKCERT_HOSTNAMES

  mv "$CAROOT"/rootCA.pem "$CAROOT"/rootCA.crt
  mv "$CAROOT"/rootCA-key.pem "$CAROOT"/rootCA.key

  cp "$CAROOT"/example.com.key "$CAROOT"/example.com.pem
  cat "$CAROOT"/example.com.crt >> "$CAROOT"/example.com.pem
  chmod +r "$CAROOT"/example.com.pem
fi

## Simplification
HOST_GROUP_NAME=${HOST_USER_NAME}
HOST_GROUP_ID=${HOST_USER_ID}

## Test if string is not empty
if [ -n "${HOST_USER_NAME}" ] && [ -n "${HOST_USER_ID}" ]; then

    ## Test if userId is not rootId
    if [ "${HOST_USER_NAME}" != 0 ] && [ "${HOST_USER_ID}" != 0 ]; then

        ## Create user with hostId in container
        groupadd -g "${HOST_GROUP_ID}" "${HOST_GROUP_NAME}"
        useradd -r -m -s /sbin/nologin -g "${HOST_GROUP_NAME}" -u "${HOST_USER_ID}" "${HOST_USER_NAME}"

        ## Change file permission
        chown -R "${HOST_USER_NAME}":"${HOST_GROUP_NAME}" "${CAROOT}"/*

    fi

fi
