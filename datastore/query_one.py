#!/usr/bin/env python

from google.cloud import datastore

client = datastore.Client()
query = client.query(kind='Diacritics')
query.add_filter("raw", "=", "אבד")
results = list(query.fetch())
assert len(results)==1
result=results[0]
print(result['possible_diacritics'])
