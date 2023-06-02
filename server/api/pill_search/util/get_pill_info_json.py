import json


def get_pill_info_json(pill_code):
    try:
        with open('assets/pill_info_all.json', 'r') as f:
            pill_info_list = json.load(f)
            pill_info_list = pill_info_list["pill_info"]

        for pill_info in pill_info_list:
            if pill_info["Kcode"] == pill_code:
                return pill_info

        result = {
            "ITEM_NAME": 'NONE',
            "ENTP_NAME": 'NONE',
            "CLASS_NAME": 'NONE',
            "Efficacy": 'NONE',
            "Dosage": 'NONE',
            "AtpnWarnQesitm": 'NONE',
            "AtpnQesitm": 'NONE',
            "IntrcQesitm": 'NONE',
            "SeQesitm": 'NONE',
            "DepositMethodQesitm": 'NONE',
            "PillImg": 'NONE',
            "PictogramList": [],
            "Kcode": 'NONE'
        }
        return result
    except Exception as e:
        return str(e)