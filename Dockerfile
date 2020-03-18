FROM debian:stable
RUN adduser --disabled-password --home /server/ --gecos 'server,,,,' server
COPY . /server/site
WORKDIR /server/site
RUN apt update
RUN apt install -y ca-certificates golang-go git make openssl
USER server
VOLUME "/server/"
CMD make build keys host
