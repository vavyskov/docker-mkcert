#!/bin/sh

if [ -z "$CAROOT" ]; then
  echo "CAROOT environment variable not defined. Please set CAROOT to the desired directory."
  exit 1
fi

if [ -z "$SERVER_HOSTNAMES" ]; then
  echo "SERVER_HOSTNAMES environment variable not defined. Please set SERVER_HOSTNAMES to the desired hostnames (each hostname being separated by a space)."
  exit 1
fi

set -e # Exit immediately if a command exits with a non-zero status.

mkcert -cert-file "$CAROOT/server.crt" -key-file "$CAROOT/server.key" $SERVER_HOSTNAMES
mkcert -pkcs12 -p12-file "$CAROOT/server.p12" $SERVER_HOSTNAMES

#echo "Creating truststore..."
#echo
#keytool -import -file "$CAROOT/rootCA.pem" -alias RootCA -keystore "$CAROOT/truststore.jks" -storepass "$JKS_PASSWORD" -trustcacerts -noprompt
#echo
#echo "Creating keystore..."
#echo
#keytool -importkeystore -srckeystore "$CAROOT/server.p12" -srcstorepass "changeit" -srcstoretype pkcs12 -destkeystore "$CAROOT/keystore.jks" -deststoretype jks -deststorepass "$JKS_PASSWORD" -destkeypass "$JKS_PASSWORD" -noprompt
#echo
#echo "Importing Root CA certificate into keystore..."
#echo
#keytool -import -file "$CAROOT/rootCA.pem" -alias RootCA -keystore "$CAROOT/keystore.jks" -storepass "$JKS_PASSWORD" -trustcacerts -noprompt

## Simplification
HOST_GROUP_NAME=${HOST_USER_NAME}
HOST_GROUP_ID=${HOST_USER_ID}

## Test if string is not empty
if [ -n "${HOST_USER_ID}" ]; then

    ## Test if userId is not rootId
    if [ "${HOST_USER_ID}" != 0 ]; then

        ## Create user with hostId in container
        groupadd -g ${HOST_GROUP_ID} ${HOST_GROUP_NAME}
        useradd -r -m -s /sbin/nologin -g ${HOST_GROUP_NAME} -u ${HOST_USER_ID} ${HOST_USER_NAME}

        ## Change file permission
        chown -R ${HOST_USER_NAME}:${HOST_GROUP_NAME} ${CAROOT}/*

    fi

fi
