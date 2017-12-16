import bisect
import os
import webapp2
import json


class Suggest(webapp2.RequestHandler):
    def __init__(self, *args, **kwargs):
        super(Suggest, self).__init__(*args, **kwargs)
        path = os.path.join(os.path.split(__file__)[0], 'data/all.json')
        with open(path, "rt") as fp:
            self.all = sorted(json.load(fp).keys())

    def post(self):
        obj = json.loads(self.request.body)
        p_naked = obj['Naked']
        pos = bisect.bisect_left(self.all, p_naked)
        raw_results = self.all[pos:pos+10]
        obj['Nakeds'] = raw_results
        jsonstring = json.dumps(obj)
        self.response.headers['Content-Type'] = 'text/plain'
        self.response.write(jsonstring)


class Naked(webapp2.RequestHandler):
    def __init__(self, *args, **kwargs):
        super(Naked, self).__init__(*args, **kwargs)
        path = os.path.join(os.path.split(__file__)[0], 'data/all.json')
        with open(path, "rt") as fp:
            self.all = json.load(fp)

    def post(self):
        jsonobject = json.loads(self.request.body)
        for obj in jsonobject:
            p_naked = obj['Naked']
            if p_naked in self.all:
                results = self.all[p_naked]
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
