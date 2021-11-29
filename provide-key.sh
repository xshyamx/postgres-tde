#!/bin/sh -e

basedir=/var/data/pg/keys
dbname=db12tde
if [ ! -f $basedir/$dbname ]; then
        head /dev/random | base64 > $basedir/$dbname
fi

# key should only be 32 bytes
sha256sum $basedir/$dbname | awk '{print $1}' | head -c 32
