#!/bin/sh
. scripts/gcloud_db_details.sh
mysql\
	--user root\
	--password\
	--database mysql\
	--host $IP\
	--ssl-ca=$HOME/.nikuda/server-ca.pem\
	--ssl-cert=$HOME/.nikuda/client-cert.pem\
	--ssl-key=$HOME/.nikuda/client-key.pem
