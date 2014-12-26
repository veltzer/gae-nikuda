#!/usr/bin/python3

'''
this script will install all the required packages that you need on
ubuntu to compile and work with this package.

It will:
	- add repositories
	- download signing keys
	- receive keys from the keyserver
	- install packages

TODO:
- only install packages if they are not already installed.
'''

###########
# imports #
###########
import subprocess # for check_call, DEVNULL, check_output
import os # for system
import os.path # for isfile

##############
# parameters #
##############
# do you want to debug this script?
opt_debug=False
# do you want to show progress?
opt_progress=True
# what ppas do you want to add?
opt_ppas=[
	'ppa:mark-veltzer/ppa',
]
# what keys to download and trust via apt-key?
opt_keys_download=[
]
# keys to receive from keyservers
opt_keys_receive=[
]
# packages to install
opt_packs=[
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

	# my packages
	'templar',
]

#############
# functions #
#############
all_keys=set()

# the lines we are interested in look like this:
# pub   4096R/EFE21092 2012-05-11
def keys_read():
	output=subprocess.check_output([
		'apt-key',
		'list',
	]).decode().strip()
	for line in output.split('\n'):
		if not line.startswith('pub'):
			continue
		parts=line.split()
		all_keys.add(parts[1].split('/')[1])

def keys_have(key_id):
	return key_id in all_keys

########
# code #
########
keys_read()
altered_apt_configuration=False
codename=subprocess.check_output([
	'lsb_release',
	'--codename',
	'--short',
	]).decode().strip()
if opt_debug:
	print('codename is [{0}]'.format(codename))

# repositories

for ppa in opt_ppas:
	if opt_progress:
		print('processing ppa [{0}]...'.format(ppa))
	# cinelerra-ppa-ppa-trusty.list
	short_ppa=ppa[4:]
	parts=short_ppa.split('/')
	filename='/etc/apt/sources.list.d/{0}-{1}-{2}.list'.format(parts[0], parts[1], codename)
	if opt_debug:
		print('filename is [{0}]'.format(filename))
	if os.path.isfile(filename):
		if opt_progress:
			print('already there in [{0}]...'.format(filename))
		continue
	altered_apt_configuration=True
	subprocess.check_call([
		'sudo',
		'add-apt-repository',
		'--enable-source', # source code too
		'--yes', # dont ask questions
		ppa
	], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

# downloaded keys

for dl, key_id in opt_keys_download:
	if opt_progress:
		print('processing download key [{0}], [{1}]...'.format(dl, key_id))
	if keys_have(key_id):
		if opt_progress:
			print('already have this key')
		continue
	altered_apt_configuration=True
	if opt_progress:
		print('downloading key...')
	os.system('wget -q -O - {0} | sudo apt-key add -'.format(dl))
	keys_read()
	assert keys_have(key_id)

# received keys

for srvr, key_id in opt_keys_receive:
	if opt_progress:
		print('processing receive key [{0}], [{1}]...'.format(srvr, key_id))
	if keys_have(key_id):
		if opt_progress:
			print('already have this key')
		continue
	altered_apt_configuration=True
	if opt_progress:
		print('receiving key...')
	subprocess.check_call([
		'sudo',
		'apt-key',
		'adv',
		'--keyserver',
		srvr,
		'--recv-keys',
		key_id,
	], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
	keys_read()
	assert keys_have(key_id)

# update apt state

if altered_apt_configuration:
	if opt_progress:
		print('updating apt states...')
	subprocess.check_call([
		'sudo',
		'apt-get',
		'update',
	],
		#stdout=subprocess.DEVNULL,
		stderr=subprocess.DEVNULL,
	)
	# remove unneeded .save apt files
	os.system('sudo rm -f /etc/apt/sources.list.d/*.save /etc/apt/sources.list.save')

# install packages

if opt_progress:
	print('installing packages...')
args=[
	'sudo',
	'apt-get',
	'install',
	'--assume-yes'
]
args.extend(opt_packs)
subprocess.check_call(args, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
