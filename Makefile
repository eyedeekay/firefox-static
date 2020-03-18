
fetch:
	mkdir -p i2p tor
	./fetch.sh
	./generate.sh
	prettier --write ./i2p/updateManifest.json
	./fakeod.sh

build:
	go get -u github.com/eyedeekay/firefox-static/sammy
	go build

docker:
	docker build -t firefox-static .
	docker run -dit \
		--restart=always \
		--network=host \
		--name=firefox-static \
		--volume /srv/https/:/server \
		firefox-static

keys:
	openssl ecparam -genkey -name secp384r1 -out ../tls.key
	openssl req -subj '/C=US' -new -x509 -sha256 -key ../tls.key -out ../tls.crt -days 3650
	touch keys

host:
	./firefox-static


