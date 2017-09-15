#!/usr/bin/env python

# This does not work

from google.appengine.ext import db
entries = Entry.all(keys_only=True)
db.delete(entries)
