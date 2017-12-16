#!/usr/bin/env python

# noinspection PyPackageRequirements
from google.cloud import datastore

section = "client-nikuda"
kind = 'Diacritics'

client = datastore.Client()
# noinspection PyTypeChecker
query = client.query(kind=kind)
results = list(query.fetch())
count = 0
for result in results:
    count += len(result['possible_diacritics'])
print(len(results), count)
