FROM debian:stable
RUN apt update
RUN apt install -y ca-certificates golang-go git make openssl
RUN adduser --disabled-password --home /server/ --gecos 'server,,,,' server
USER server
COPY . /server/site
WORKDIR /server/site
VOLUME "/server/"
CMD make fetch build keys host
