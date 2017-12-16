"""
dependencies for this project
"""


def populate(d):
    d.tools = [
        'jsl',
        'jsmin',
        'closure',
        'css-validator',
    ]
    d.packs = [
        # for validating html
        'tidy',
        # for uploading via ftp
        'ncftp',
        # for jsl and other stuff
        'python',
        # for mysql
        'mysql-server',
        # for local apache web server
        'apache2',
        # for php support for apache
        'libapache2-mod-php',
        # for mysql support for php
        'php-mysql',
        # for json support for php
        'php-json',
        # for the css-validator (which is written in java) to work
        'oracle-java7-installer',
        # for templating
        'gpp',
        # for the local gcloud server to be able to do php
        'php-cgi',
        # other ftp client
        'lftp',
        # for jslint
        'nodejs',
        # for jslint
        'npm',
        # for gjslint
        'closure-linter',
        # for csstidy
        'csstidy',
    ]


def get_deps():
    return [
        __file__,  # myself
    ]
