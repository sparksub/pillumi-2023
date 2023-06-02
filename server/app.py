from flask import Flask, render_template
from flask_restx import Api

from api.pill_model.segmentation import load_segment_model
from api.pill_search.pill_search import pill_search
import utils

app = Flask(__name__)
api = Api(app, title="Pillumi API Documentation")


def create_app():
    app.config['JSON_AS_ASCII'] = False

    return app, api


if __name__ == "__main__":
    # os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'

    @app.route("/manual")
    def manual():
        return render_template("pillumi.html")


    load_segment_model()

    api.add_namespace(pill_search)
    app.run(utils.ip, port=5000, debug=True)
