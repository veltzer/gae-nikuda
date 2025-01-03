import bisect
import os
import json
from flask import Flask, request, jsonify


app = Flask(__name__)

# setup
path = os.path.join(os.path.split(__file__)[0], "data/all.json")
with open(path, "rt", encoding="UTF8") as fp:
    all_dict = json.load(fp)
    all_sorted = sorted(all_dict.keys())

# this route is not needed in production
@app.route("/", methods=["GET"])
def index():
    return app.send_static_file("html/index.html")

@app.route("/app/suggest", methods=["POST"])
def suggest():
    obj = request.get_json()
    p_naked = obj["Naked"]
    pos = bisect.bisect_left(all_sorted, p_naked)
    raw_results = all_sorted[pos:pos+10]
    obj["Nakeds"] = raw_results
    return jsonify(obj)


@app.route("/app/naked", methods=["POST"])
def naked():
    jsonobject = request.get_json()
    for obj in jsonobject:
        p_naked = obj["Naked"]
        if p_naked in all_dict:
            results = all_dict[p_naked]
        else:
            results = []
        obj["Nikudim"] = results
    return jsonify(jsonobject)


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8080, debug=True)
