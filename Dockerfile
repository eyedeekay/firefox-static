FROM debian:stable
RUN apt update
RUN apt install -y ca-certificates golang-go git make openssl
RUN adduser --disabled-password --home /server/ --gecos 'server,,,,' server
USER server
VOLUME "/server/"
COPY . /opt/site
WORKDIR /server/site
RUN make -C /opt/site -f /opt/site/Makefile fetch build
CMD RUN make -f /opt/site/Makefile keys && /opt/site/firefox-static

