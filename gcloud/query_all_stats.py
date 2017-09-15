#!/usr/bin/env python

import configparser
import getpass
import os.path
from google.cloud import datastore
import mysql.connector
import tqdm

section = "client-nikuda"
kind = 'Diacritics'

client = datastore.Client()
query = client.query(kind=kind)
results = list(query.fetch())
count = 0
for result in results:
    count += len(result['possible_diacritics'])
print(len(results), count)
