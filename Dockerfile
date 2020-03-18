FROM debian:stable
RUN apt update
RUN apt install -y ca-certificates golang-go git make openssl
RUN adduser --disabled-password --home /server/ --gecos 'server,,,,' server
VOLUME "/server/"
COPY firefox-static /bin/firefox-static
WORKDIR /server/site
RUN chown -R server:server /server/
CMD openssl ecparam -genkey -name secp384r1 -out ../tls.key && \
	openssl req -subj '/CN=./O=i2pinprivatebrowsing LTD./C=US' -new -x509 -sha256 -key ../tls.key -out ../tls.crt -days 3650 && \
    su - server /bin/firefox-static

