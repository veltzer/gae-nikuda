#!/bin/sh
. scripts/gcloud_db_details.sh
mysql\
	--user admin\
	--database nikuda\
	--host $IP\
	--ssl_ca=$HOME/.nikuda/server-ca.pem\
	--ssl_cert=$HOME/.nikuda/client-cert.pem\
	--ssl_key=$HOME/.nikuda/client-key.pem\
	< db/nikuda.mysqldump
