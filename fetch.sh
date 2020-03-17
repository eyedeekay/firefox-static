#! /usr/bin/env sh

RELEASES=$(gothub info -u eyedeekay -r I2P-in-Private-Browsing-Mode-Firefox | grep http | sed 's/(.*//' | sed 's|1.26||g' | sed 's|1.25||g' | sed 's|docs||g' | tr -d "\- ")

for release in $RELEASES; do
    echo "$release"
    wget -c -O i2p/i2ppb-$release@eyedeekay.github.io.xpi https://github.com/eyedeekay/I2P-in-Private-Browsing-Mode-Firefox/releases/download/$release/i2ppb@eyedeekay.github.io.xpi
done


