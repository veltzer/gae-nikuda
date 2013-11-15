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
]

args=['sudo','apt-get','install']
args.extend(packs)
subprocess.check_call(args)
