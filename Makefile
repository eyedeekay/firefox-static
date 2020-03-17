
fetch:
	mkdir -p i2p tor
	./fetch.sh
	./generate.sh
	prettier --write ./i2p/updateManifest.json
	./fakeod.sh

keys:
	openssl ecparam -genkey -name secp384r1 -out ../tls.key
	openssl req -new -x509 -sha256 -key ../tls.key -out ../tls.crt -days 3650

host:
	./firefox-static