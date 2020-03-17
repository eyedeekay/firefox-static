
fetch:
	mkdir -p i2p tor
	./fetch.sh
	./generate.sh
	prettier --write ./i2p/updateManifest.json
	./fakeod.sh