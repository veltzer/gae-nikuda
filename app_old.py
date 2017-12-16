import webapp2
import json
# noinspection PyPackageRequirements
from google.appengine.ext import ndb


class Diacritics(ndb.Model):
    raw = ndb.StringProperty()
    possible_diacritics = ndb.StringProperty(repeated=True)


class Suggest(webapp2.RequestHandler):
    def __init__(self, *args, **kwargs):
        super(Suggest, self).__init__(*args, **kwargs)
        self.cache = dict()

    def post(self):
        obj = json.loads(self.request.body)
        p_naked = obj['Naked']
        if p_naked in self.cache:
            raw_results = self.cache[p_naked]
        else:
            # the unicode letter at the end of the next line is "taf" in hebrew
            query = Diacritics.query(Diacritics.raw >= p_naked, Diacritics.raw <= p_naked + u'\u05EA')
            results = query.fetch(10)
            raw_results = [result.raw for result in results]
            self.cache[p_naked] = raw_results
        obj['Nakeds'] = raw_results
        jsonstring = json.dumps(obj)
        self.response.headers['Content-Type'] = 'text/plain'
        self.response.write(jsonstring)


class Naked(webapp2.RequestHandler):
    def __init__(self, *args, **kwargs):
        super(Naked, self).__init__(*args, **kwargs)
        self.cache = dict()

    def post(self):
        jsonobject = json.loads(self.request.body)
        for obj in jsonobject:
            p_naked = obj['Naked']
            if p_naked in self.cache:
                results = self.cache[p_naked]
            else:
                query = Diacritics.query(Diacritics.raw == p_naked)
                results = query.fetch()
                # there can be no more than one result
                assert len(results) <= 1, "got more than 1 result"
                if len(results) == 1:
                    results = results[0].possible_diacritics
                else:
                    results = []
                self.cache[p_naked] = results
            obj['Nikudim'] = results
        jsonstring = json.dumps(jsonobject)
        self.response.headers['Content-Type'] = 'text/plain'
        self.response.write(jsonstring)


app = webapp2.WSGIApplication(
    [
        ('/app/naked', Naked),
        ('/app/suggest', Suggest),
    ],
    debug=False,
)


# def main():
#     # noinspection PyPackageRequirements
#     from paste import httpserver
#     httpserver.serve(app, host='127.0.0.1', port='8080')
#
#
# if __name__ == '__main__':
#     main()
