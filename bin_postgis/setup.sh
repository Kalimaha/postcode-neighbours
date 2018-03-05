chmod 600 /etc/ssl/private/ssl-cert-snakeoil.key

CONF="/etc/postgresql/10/main/postgresql.conf"

echo "host    all             all             all               md5" >> /etc/postgresql/10/main/pg_hba.conf
echo "host    all             all             all               md5" >> /etc/postgresql/10/main/pg_hba.conf
echo "host    all             all             all               md5" >> /etc/postgresql/10/main/pg_hba.conf
echo "listen_addresses = '*'" >> /etc/postgresql/10/main/postgresql.conf
echo "port = 5432" >> /etc/postgresql/10/main/postgresql.conf

echo "ssl = true" >> $CONF
echo "ssl_cert_file = '/etc/ssl/certs/ssl-cert-snakeoil.pem'" >> $CONF
echo "ssl_key_file = '/etc/ssl/private/ssl-cert-snakeoil.key'" >> $CONF
