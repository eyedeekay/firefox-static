#! /usr/bin/env sh

echo '{' > ./i2p/updateManifest.json
echo '  "addons": {' >> ./i2p/updateManifest.json
echo '    "i2ppb@eyedeekay.github.io": {' >> ./i2p/updateManifest.json
echo '      "updates": [' >> ./i2p/updateManifest.json

for f in ./i2p/*.xpi; do
    v=$(echo $f | sed 's|./i2p/i2ppb-||g'| sed 's|@eyedeekay.github.io.xpi||g')
    echo '        {' >> ./i2p/updateManifest.json
    echo '          '\"update_url\": \"$f\", | sed 's|./i2p|http://127.0.0.1:7657/i2psnark|g' >> ./i2p/updateManifest.json
    echo '          '\"version\": \"$v\", >> ./i2p/updateManifest.json
    echo '          '\"update_hash\": \"sha256sum:$(sha256sum $f | sed 's/ .*//')\" >> ./i2p/updateManifest.json
    echo '        },' >> ./i2p/updateManifest.json
done

echo '      ]' >> ./i2p/updateManifest.json
echo '    }' >> ./i2p/updateManifest.json
echo '  }' >> ./i2p/updateManifest.json
echo '}' >> ./i2p/updateManifest.json

sed '
    $x;$G;/\(.*\),/!H;//!{$!d
};  $!x;$s//\1/;s/^\n//' ./i2p/updateManifest.json

#cat ./i2p/updateManifest.json