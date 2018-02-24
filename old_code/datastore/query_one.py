#!/usr/bin/env python
# coding=utf-8

# noinspection PyPackageRequirements
from google.cloud import datastore

client = datastore.Client()
# noinspection PyTypeChecker
query = client.query(kind='Diacritics')
query.add_filter("raw", "=", u"אבד")
results = list(query.fetch())
assert len(results) == 1
result = results[0]
print(result['possible_diacritics'])
