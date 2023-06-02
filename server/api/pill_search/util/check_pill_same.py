import pandas as pd
import json

labels_df = pd.read_excel("e약은요정보검색.xlsx")
print(labels_df.columns)
have_df = []

result = []

pill_json = {
    '품목일련번호': '',
    '제품명': '',
    '업체명': '',
    'Kcode': ''
}

with open('pill_name_list.json', 'r') as f:
    have_df = json.load(f)
    have_df = have_df['name']

with open('pill_label_path_sharp_score.json', 'r') as f:
    Kcode_df = json.load(f)
    Kcode_df = Kcode_df['pill_label_path_sharp_score']

for i, pill in enumerate(have_df):
    pill_name = pill
    check = pill_name.find(' ')
    if not check == -1:
        pill_name = pill_name[:check]

    check = pill_name.find('mg')
    if not check == -1:
        pill_name = pill_name[:check]

    check = pill_name.find('(')
    if not check == -1:
        pill_name = pill_name[:check]

    finds = labels_df[labels_df['제품명'].str.contains(pill_name)]
    if not finds.empty:
        pill_list = finds.values.tolist()
        if len(pill_list) > 1:
            for pill_name in pill_list:
                print(pill_name[1])
            print(pill)
            num = int(input())

            if num == 999:
                continue
            pill_json = {
                '품목일련번호': pill_list[num-1][0],
                '제품명': pill_list[num-1][1],
                '업체명': pill_list[num-1][2],
                'Kcode': Kcode_df[i][1]
            }
            result.append(pill_json)
        else:
            pill_json = {
                '품목일련번호': pill_list[0][0],
                '제품명': pill_list[0][1],
                '업체명': pill_list[0][2],
                'Kcode': Kcode_df[i][1]
            }
            result.append(pill_json)



finds = labels_df[labels_df['제품명'].str.contains('타이레놀')]
if not finds.empty:
    pill_list = finds.values.tolist()

    for sample in pill_list:
        pill_json = {
            '품목일련번호': sample[0],
            '제품명': sample[1],
            '업체명':  sample[2],
            'Kcode': Kcode_df[634][1]
        }
        result.append(pill_json)

with open('pill_same_list.json', 'w', encoding='utf-8') as file_write:
    json.dump(result, file_write, ensure_ascii=False, indent=4)

print(len(result))
