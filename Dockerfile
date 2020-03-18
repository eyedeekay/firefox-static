FROM debian:stable
RUN apt update
RUN apt install -y ca-certificates golang-go git make openssl
RUN adduser --disabled-password --home /server/ --gecos 'server,,,,' server
VOLUME "/server/"
COPY . /opt/site
WORKDIR /server/site
RUN chown -R server:server /server/
USER server
CMD make -f /opt/site/Makefile keys && cp -r /opt/site/ /server/site/ &&  /opt/site/firefox-static

