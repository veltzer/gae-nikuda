# Copyright 2016 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import webapp2
import os.path
import json
import logging
# from google.cloud import datastore
from google.appengine.ext import ndb

class Diacritics(ndb.Model):
    raw = ndb.StringProperty()
    possible_diacritics = ndb.StringProperty(repeated=True)


class Naked(webapp2.RequestHandler):
    def get(self):
        self.response.headers['Content-Type'] = 'text/plain'
        self.response.write('This is a response from the get handler of Naked')
    def post(self):
        jsonobject = json.loads(self.request.body)
        logging.info("object is {}".format(jsonobject))
        for obj in jsonobject:
            p_naked = obj['Naked']
            p_id = obj['ID']
            query = Diacritics.query(Diacritics.raw == p_naked)
            results = query.fetch()
            logging.info(results)
            assert len(results) == 1
            obj['Nikudim'] = results[0].possible_diacritics
        jsonstring = json.dumps(jsonobject)
        logging.info("writing {}".format(jsonstring))
        self.response.headers['Content-Type'] = 'text/plain'
        self.response.write(jsonstring)

app = webapp2.WSGIApplication(
    [
        ('.*', Naked),
    ],
    debug=True,
)

def main():
    from paste import httpserver
    httpserver.serve(app, host='127.0.0.1', port='8080')

if __name__ == '__main__':
    main()

