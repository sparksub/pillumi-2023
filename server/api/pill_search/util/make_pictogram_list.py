import pandas as pd


def make_pictogram_list(pill_info):
    pictogram_info = pd.read_csv('pictogram-info.csv')
    pictogram_info = pictogram_info.values
    pictogram_list = []

    group = ["용법", "부작용", "주의사항", "상호작용", "금지사항", "보관방법"]
    eng_group = ['Dosage', 'AtpnWarnQesitm', 'AtpnQesitm', 'IntrcQesitm', 'SeQesitm', 'DepositMethodQesitm']
    # Dosage = 5 용법
    # AtpnWarnQesitm = 6 부작용
    # AtpnQesitm = 7 주의사항
    # IntrcQesitm = 8 상호작용
    # SeQesitm = 9 금지사항
    # DepositMethodQesitm = 10 보관방법

    for j, subgroup in enumerate(group):
        value_list = []
        for i, item in enumerate(pictogram_info):
            if (item[1] == subgroup) and (pill_info[eng_group[j]] != 'nan'):
                if not pd.isna(item[3]):
                    word_list = item[3].split(', ')
                    check = False
                    for word in range(0, len(word_list)):
                        pill_check = str(pill_info[eng_group[j]])
                        result_in = pill_check.find(word_list[word])
                        if check:
                            break
                        if result_in != -1:
                            if not pd.isna(item[2]):
                                if pill_check.find(item[2]) != -1:
                                    value_list.append(item[0])
                                    check = True
                            else:
                                value_list.append(item[0])
                                check = True
        pictogram_list.append(value_list)

    pictogram_json = {
        "Dosage": pictogram_list[0],
        "AtpnWarnQesitm": pictogram_list[1],
        "AtpnQesitm": pictogram_list[2],
        "IntrcQesitm": pictogram_list[3],
        "SeQesitm": pictogram_list[4],
        "DepositMethodQesitm": pictogram_list[5]
    }

    return pictogram_json