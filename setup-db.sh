#!/bin/sh -e

sudo mkdir -p /var/data/pg/keys /var/data/pg/db12tde
sudo cp /vagrant/provide-key.sh /var/data/pg/keys
sudo chmod +x /var/data/pg/keys/provide-key.sh
sudo chown -R vagrant:vagrant /var/data/pg/db12tde /var/data/pg/keys

# find locale by
# locale -a | grep utf
/usr/local/pg12tde/bin/initdb -D /var/data/pg/db12tde \
			 -K /var/data/pg/keys/provide-key.sh \
			 --locale=en_US.utf8

/usr/local/pg12tde/bin/pg_ctl -D /var/data/pg/db12tde start
