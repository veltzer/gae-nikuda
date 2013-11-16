#!/usr/bin/python

'''
this scrip will install all the required packages that you need on
ubuntu to compile and work with this package.
'''

from __future__ import print_function
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
]

args=['sudo','apt-get','install']
args.extend(packs)
subprocess.check_call(args)
