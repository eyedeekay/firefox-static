FROM debian:stable
RUN apt update
RUN apt install -y ca-certificates golang-go git make openssl
RUN adduser --disabled-password --home /server/ --gecos 'server,,,,' server
USER server
VOLUME "/server/"
COPY . /server/site
WORKDIR /server/site
CMD make fetch build keys host
