import pandas as pd
import json

from api.pill_search.util.make_pictogram_list import make_pictogram_list


def clean_txt(txt):
    txt = str(txt)
    txt = txt.replace("  ", "\n")
    txt = txt.replace(" ", " ")
    txt = txt.replace("</p>", "")
    txt = txt.replace("|", ", ")
    txt = txt.replace(".", ".\n")
    txt = txt.replace("HTTPS://NEDRUG.MFDS.GO.KR/PBP/CMN/ITEMIMAGEDOWNLOAD/",
                      "http://nedrug.mfds.go.kr/pbp/cmn/itemImageDownload/")
    new_txt = txt.replace("\xa0", " ")
    return new_txt


def get_pill_info(pill_code, pill_class, pill_img):
    """
    api 결과 정리 (** 알약 분류정보 없음**)
    # 0 'entpName' : 업체명
    # 1 'itemName' : 제품명
    # 3 'efcyQesitm' : 효능
    # 4 'useMethodQesitm' : 사용법
    # 5 'atpnWarnQesitm' : 사용전, 주의사항경고
    # 6 'atpnQesitm' : 사용 시, 주의사항
    # 7 'intrcQesitm' : 상호작용
    # 8 'seQesitm' : 부작용
    # 9 'depositMethodQesitm' : 보관법
    # 12 'itemImage' : 이미지
    """

    try:
        labels_df = pd.read_excel("e약은요정보검색.xlsx")
        # print(labels_df.columns)
        labels_df.columns = ['품목일련번호', 'ITEM_NAME', 'ENTP_NAME', '주성분', 'Efficacy', 'Dosage',
                             'AtpnWarnQesitm', 'AtpnQesitm', 'IntrcQesitm', 'SeQesitm', 'DepositMethodQesitm', '공개일자',
                             '수정일자']

        # print(labels_df.columns)
        info_df = pd.read_csv("pill_kr.csv")
        # print(info_df.columns)
        # pill_json = {
        #     '품목일련번호': '',
        #     '제품명': '',
        #     '업체명': '',
        #     '주성분': '',
        #     '이 약의 효능은 무엇입니까?': '',
        #     '이 약은 어떻게 사용합니까?': '',
        #     '이 약을 사용하기 전에 반드시 알아야 할 내용은 무엇입니까?': '',
        #     '이 약의 사용상 주의사항은 무엇입니까?': '',
        #     '이 약을 사용하는 동안 주의해야 할 약 또는 음식은 무엇입니까?': '',
        #     '이 약은 어떤 이상반응이 나타날 수 있습니까?': '',
        #     '이 약은 어떻게 보관해야 합니까?': '',
        # }

        result = []
        with open('pill_same_list.json', 'r') as f:
            have_df = json.load(f)

        for have in have_df:
            if (have['제품명'] in info_df['ITEM_NAME'].values.tolist()) or (
                    have['품목일련번호'] in info_df['ITEM_SEQ'].values.tolist()):
                try:
                    pill_info = info_df[info_df['ITEM_NAME'] == have['제품명']].values.tolist()[0]
                    pill_easy = labels_df[labels_df['ITEM_NAME'] == have['제품명']]

                    pill_result = {
                        "ITEM_NAME": pill_easy['ITEM_NAME'].values.tolist()[0],
                        "ENTP_NAME": pill_easy['ENTP_NAME'].values.tolist()[0],
                        "CLASS_NAME": pill_info[19],
                        "Efficacy": clean_txt(pill_easy['Efficacy'].values.tolist()[0]),  # 효능
                        "Dosage": clean_txt(pill_easy['Dosage'].values.tolist()[0]),  # Dosage = 5 용법
                        "AtpnWarnQesitm": clean_txt(pill_easy['AtpnWarnQesitm'].values.tolist()[0]),
                        # AtpnWarnQesitm = 6 부작용
                        "AtpnQesitm": clean_txt(pill_easy['AtpnQesitm'].values.tolist()[0]),  # AtpnQesitm = 7 주의사항
                        "IntrcQesitm": clean_txt(pill_easy['IntrcQesitm'].values.tolist()[0]),  # IntrcQesitm = 8 상호작용
                        "SeQesitm": clean_txt(pill_easy['SeQesitm'].values.tolist()[0]),  # SeQesitm = 9 금지사항
                        "DepositMethodQesitm": clean_txt(pill_easy['DepositMethodQesitm'].values.tolist()[0]),
                        # DepositMethodQesitm = 10 보관방법
                        "PillImg": pill_info[6],
                        "PictogramList": [],
                        "Kcode": have["Kcode"]
                    }

                    pill_result["PictogramList"] = make_pictogram_list(pill_result)

                    result.append(pill_result)
                    print(pill_result["ITEM_NAME"])
                except:
                    continue

        data = {"pill_info": result}

        with open("pill_info_all.json", 'w', encoding='utf-8') as file_write:
            json.dump(data, file_write, ensure_ascii=False, indent=4)

    except Exception as e:
        return str(e)
