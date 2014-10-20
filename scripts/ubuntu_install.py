#!/usr/bin/python3

'''
this script will install all the required packages that you need on
ubuntu to compile and work with this package.
'''

import subprocess # for check_call

packs=[
	'tidy', # for validating html
	'ncftp', # for uploading via ftp
	'python', # for jsl and other stuff
	'mysql-server', # for mysql
	'apache2', # for local apache web server
	'libapache2-mod-php5', # for php support for apache
	'php5-mysql', # for mysql support for php
	'php5-json', # for json support for php
	'openjdk-7-jdk', # for the css-validator (which is written in java) to work
	'gpp', # for templating
	'php5-cgi', # for the local gcloud server to be able to do php
	'lftp', # other ftp client
	'nodejs', # for jslint
	'npm', # for jslint
	'node', # for jslint
]

args=['sudo','apt-get','install','--assume-yes']
args.extend(packs)
subprocess.check_call(args)
