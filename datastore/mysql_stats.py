#!/usr/bin/env python

import os.path

import configparser
# noinspection PyPackageRequirements
import mysql.connector

section = "client-nikuda"


def get_config():
    d = {}
    inifile = os.path.expanduser('~/.my.cnf')
    assert os.path.isfile(inifile)
    config = configparser.ConfigParser()
    config.read(inifile)
    assert config.has_section(section)
    assert config.has_option(section, 'user')
    assert config.has_option(section, 'password')
    assert config.has_option(section, 'database')
    d['user'] = config.get(section, 'user')
    d['password'] = config.get(section, 'password')
    d['database'] = config.get(section, 'database')
    return d


def chunks(l, n):
    """Yield successive n-sized chunks from l."""
    for i in range(0, len(l), n):
        yield l[i:i + n]


def main():
    db = mysql.connector.Connect(**get_config())
    cursor = db.cursor()
    cursor.execute('SELECT Naked, Nikud FROM wordlist')
    d = dict()
    count = 0
    for row in cursor:
        naked = row[0]
        nikud = row[1]
        if naked == '':
            continue
        if naked not in d:
            d[naked] = []
        d[naked].append(nikud)
        count += 1
    db.close()
    print(len(d), count)


if __name__ == "__main__":
    main()
