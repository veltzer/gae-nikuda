import bisect
import os
import webapp2
import json


path = os.path.join(os.path.split(__file__)[0], 'data/all.json')
with open(path, "rt") as fp:
    all_dict = json.load(fp)
    all_sorted = sorted(all_dict.keys())


class Suggest(webapp2.RequestHandler):
    def post(self):
        obj = json.loads(self.request.body)
        p_naked = obj['Naked']
        pos = bisect.bisect_left(all_sorted, p_naked)
        raw_results = all_sorted[pos:pos+10]
        obj['Nakeds'] = raw_results
        jsonstring = json.dumps(obj)
        self.response.headers['Content-Type'] = 'text/plain'
        self.response.write(jsonstring)


class Naked(webapp2.RequestHandler):
    def post(self):
        jsonobject = json.loads(self.request.body)
        for obj in jsonobject:
            p_naked = obj['Naked']
            if p_naked in all_dict:
                results = all_dict[p_naked]
            else:
                results = []
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
