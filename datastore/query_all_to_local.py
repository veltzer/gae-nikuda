#!/usr/bin/env python

import json
# noinspection PyPackageRequirements
from google.cloud import datastore
import codecs
import pickle

section = "client-nikuda"
kind = 'Diacritics'

client = datastore.Client()
# noinspection PyTypeChecker
query = client.query(kind=kind)
results = list(query.fetch(10))
# results = list(query.fetch())
d = {}
for result in results:
    d[result['raw']] = result['possible_diacritics']
with codecs.open("db/10.json", "wt", encoding="utf-8") as fp:
    json.dump(d, fp)
with open("db/10.pickle", "wb") as fp:
    pickle.dump(d, fp, pickle.HIGHEST_PROTOCOL)
