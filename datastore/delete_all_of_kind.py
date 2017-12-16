#!/usr/bin/env python

# noinspection PyPackageRequirements
from google.cloud import datastore

client = datastore.Client()
client.delete_multi(keys=[])
