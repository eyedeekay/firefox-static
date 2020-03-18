FROM debian:stable
RUN apt update
RUN apt install -y ca-certificates golang-go git make openssl
RUN adduser --disabled-password --home /server/ --gecos 'server,,,,' server
VOLUME "/server/"
COPY . /opt/site
WORKDIR /server/site
RUN make -C /opt/site -f /opt/site/Makefile fetch build
USER server
CMD RUN make -f /opt/site/Makefile keys && cp -r /opt/site/ /server/site/ &&  /opt/site/firefox-static

