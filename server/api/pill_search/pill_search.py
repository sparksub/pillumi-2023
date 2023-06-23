
import io

from flask import request
from flask_restx import Namespace, Resource
from PIL import Image
import pandas as pd

import base64

from api.pill_model.segmentation import segmentation
from api.pill_search.ai_model.PillMain import PillMain
from api.pill_search.model.pill_search_request import *
from api.pill_search.util.get_pill_info_json import get_pill_info_json

result_front_url = '/Users/subinpark/Development/project/pillumi-2023/server/assets/results/result_front.png'
result_back_url = '/Users/subinpark/Development/project/pillumi-2023/server/assets/results/result_back.png'

pill_search = Namespace("pillsearch")

pill_search_field = pill_search.model("pillsearchrequest", pill_search_request)
pill_search_request_field = pill_search.model("pillsearch", pill_search_response)

@pill_search.route("/")
class search_pill(Resource):
    @pill_search.expect(pill_search_field)
    @pill_search.response(200, "검색 성공", pill_search_request_field)
    @pill_search.doc(
        resources={
            400: "검색 실패",
        }
    )
    def post(self):
        """
        알약 검색
        :return: 알약 검색 결과
        """

        try:
            data = request.get_json()
            raw_front = data['image_front']
            raw_back = data['image_back']

            # decode_base64(img.read())
            image_front = Image.open(io.BytesIO(base64.b64decode(raw_front)))
            image_back = Image.open(io.BytesIO(base64.b64decode(raw_back)))
            #
            image_front.save('assets/pill_front.jpg')
            image_back.save('assets/pill_back.jpg')
            #
            segmentation('assets/pill_front.jpg', result_front_url)
            segmentation('assets/pill_back.jpg', result_back_url)


            searching_pill = PillMain()
            result_pills = searching_pill.main(['assets/results/result_front.png', 'assets/results/result_back.png'])
            # result_pills = searching_pill.main(['assets/pill_front.jpg', 'assets/pill_back.jpg'])

            pred = []

            for pill in result_pills:
                pred.append(pill["code"])
            print(pred)

            # result = get_pill_info_json(pred[0])
            similar = []

            for i in pred:
                similar.append(get_pill_info_json(i))
            return {
                "ResultsPill": similar
            }, 200

        except Exception as e:
            print(str(e))
            return (str(e)), 400
