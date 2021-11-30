#!/bin/sh -e

if [ ! -f postgresql-12.3_TDE_1.0.tar.gz ]; then
	curl -LO https://download.cybertec-postgresql.com/postgresql-12.3_TDE_1.0.tar.gz
fi

if [ ! -d postgresql-12.3_TDE_1.0 ]; then
	tar zxf postgresql-12.3_TDE_1.0.tar.gz
fi

sudo dnf install -y \
		 gcc perl bison flex \
		 readline-devel zlib-devel openssl-devel bind-devel openldap-devel python-devel bison-devel

cd postgresql-12.3_TDE_1.0

sudo mkdir -p /usr/local/pg12tde
sudo chown -R vagrant:vagrant  /usr/local/pg12tde

if [ ! -d /usr/local/pg12tde/bin ]; then
	./configure \
		--prefix=/usr/local/pg12tde \
		--with-openssl \
		--with-perl \
		--with-python \
		--with-ldap

	make install
	cd contrib
	make install
fi
