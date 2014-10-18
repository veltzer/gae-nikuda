#!/bin/sh
mysql\
	--user admin\
	--database nikuda\
	--host 173.194.110.159\
	--ssl_ca=~/.nikuda/server-ca.pem\
	--ssl_cert=~/.nikuda/client-cert.pem\
	--ssl_key=~/.nikuda/client-key.pem\
	< db/nikuda.mysqldump
