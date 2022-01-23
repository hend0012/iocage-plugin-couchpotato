#!/bin/sh

echo "Download couchpotato repo"
git clone https://github.com/CouchPotato/CouchPotatoServer.git /usr/local/CouchPotatoServer

echo "Create couchpotato user"
pw user add couchpotato -c "CouchPotato" -d /nonexistent -s /usr/bin/nologin -w no
chown -R couchpotato:couchpotato /usr/local/CouchPotatoServer

mkdir -p /.cargo
chown -R couchpotato:couchpotato /.cargo

echo "Installing CouchPotato service"
mkdir -p /usr/local/etc/rc.d
cp /usr/local/CouchPotatoServer/init/freebsd /usr/local/etc/rc.d/couchpotato
sed -i '' "s/python/python2/g" /usr/local/etc/rc.d/couchpotato

echo "Executing CouchPotato service"
ln -s /usr/local/bin/python2.7 /usr/bin/python2
chmod u+x /usr/local/etc/rc.d/couchpotato
sysrc "couchpotato_enable=YES"
service couchpotato start
