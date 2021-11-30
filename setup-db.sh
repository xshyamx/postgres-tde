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

sed -i "s/#listen_addresses/listen_addresses = '*'\n#listen_addresses/" /var/data/pg/db12tde/postgresql.conf
sed -i "s/#password_encryption/password_encryption = scram-sha-256\n#password_encryption/" /var/data/pg/db12tde/postgresql.conf

echo 'host    all             all             0.0.0.0/0               scram-sha-256' >> /var/data/pg/db12tde/pg_hba.conf

/usr/local/pg12tde/bin/pg_ctl -D /var/data/pg/db12tde start

/usr/local/pg12tde/bin/psql postgres -c "show password_encryption;
alter user vagrant with password 'vagrant';
select rolpassword from pg_authid where rolname = 'vagrant';"

/usr/local/pg12tde/bin/pg_ctl -D /var/data/pg/db12tde reload

cat <<EOF
PostgreSQL with TDE started 

JDBC Connection Parameters
==========================

     URL: jdbc:postgresql://localhost:5432/postgres
USERNAME: vagrant
PASSWORD: vagrant
EOF
