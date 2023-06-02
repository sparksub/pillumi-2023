import os
import shutil
from api.pill_model.segmentation import *

load_segment_model()


def check_point():
    rootPath = "/Users/subinpark/Development/drugfill/source/drugfill_modeling_source_code/sample_img/"
    folder_name = ["training", "validation", "testing"]
    our = ['K-008902', 'K-005886', 'K-046737']

    if not os.path.isdir(os.path.join(rootPath, "segment")):
        os.mkdir(os.path.join(rootPath, "segment"))

    for folder in folder_name:
        folder_path = os.path.join(rootPath, folder)
        print(folder_path)
        if not os.path.isdir(os.path.join(rootPath, f"segment/{folder}")):
            os.mkdir(os.path.join(rootPath, f"segment/{folder}"))


    folder_path = os.path.join(rootPath, folder_name[0])
    ref_pill_file_list = os.listdir(folder_path)
    print(ref_pill_file_list)

    # 우리 알약 segment
    # for folder in folder_name:
    #     folder_path = os.path.join(rootPath, folder)
    #     for pill_file in our:
    #         if os.path.isdir(os.path.join(rootPath, f"segment/{folder}/{pill_file}")):
    #             continue
    #         if folder == 'training' and os.path.isdir(os.path.join(rootPath, f"{folder_path}/{pill_file}")):
    #             continue
    #         os.mkdir(os.path.join(rootPath, f"segment/{folder}/{pill_file}"))
    #         file_list = os.listdir(f"{folder_path}/{pill_file}")
    #
    #         for pill_num, pill in enumerate(file_list):
    #             print(pill)
    #             name, ext = os.path.splitext(pill)
    #             if not ext == ".png":
    #                 continue
    #             if name[:5] == "._K-0":
    #                 continue
    #             file_path = f"{folder_path}/{pill_file}/{pill}"
    #             save_path = f"{rootPath}segment/{folder}/{pill_file}/{pill}"
    #
    #             print(file_path)
    #             print(save_path)
    #
    #             segmentation(file_path, save_path)

    for folder in folder_name:
        folder_path = os.path.join(rootPath, folder)
        for pill_file in ref_pill_file_list:
            if not os.listdir(os.path.join(rootPath, f"segment/{folder}/{pill_file}")) == []:
                continue
            # os.mkdir(os.path.join(rootPath, f"segment/{folder}/{pill_file}"))
            file_list = os.listdir(f"{folder_path}/{pill_file}")

            for pill_num, pill in enumerate(file_list):
                print(pill)
                name, ext = os.path.splitext(pill)
                if not ext == ".png":
                    continue
                if name[:5] == "._K-0":
                    continue
                file_path = f"{folder_path}/{pill_file}/{pill}"
                save_path = f"{rootPath}segment/{folder}/{pill_file}/{pill}"

                print(file_path)
                print(save_path)
                segmentation(file_path, save_path)






def segment_dataset():
    rootPath = "/Users/subinpark/Development/drugfill/source/drugfill_modeling_source_code/sample_img/"
    folder_name = ["training", "validation", "testing"]
    if not os.path.isdir(os.path.join(rootPath, "segment")):
        os.mkdir(os.path.join(rootPath, "segment"))

    for folder in folder_name:
        folder_path = os.path.join(rootPath, folder)
        print(folder_path)

        if not os.path.isdir(os.path.join(rootPath, f"segment/{folder}")):
            os.mkdir(os.path.join(rootPath, f"segment/{folder}"))
        pill_file_list = os.listdir(folder_path)

        for pill_file in pill_file_list:
            if os.path.isdir(os.path.join(rootPath, f"segment/{folder}/{pill_file}")):
                continue
            os.mkdir(os.path.join(rootPath, f"segment/{folder}/{pill_file}"))
            file_list = os.listdir(f"{folder_path}/{pill_file}")

            for pill_num, pill in enumerate(file_list):
                print(pill)
                name, ext = os.path.splitext(pill)
                if not ext == ".png":
                    continue
                if name[:5] == "._K-0":
                    continue
                file_path = f"{folder_path}/{pill_file}/{pill}"
                save_path = f"{rootPath}segment/{folder}/{pill_file}/{pill}"

                print(file_path)
                print(save_path)

                segmentation(file_path, save_path)


def delete_dataset():
    rootPath = "/home/gpuadmin/repo/drugfill_modeling_source_code/segment/"
    folder_name = ["training", "validation", "testing"]
    our = ['K-008902', 'K-009379', 'K-005886', 'K-046737']
    delete_list = []

    # for folder in folder_name:
    #     folder_path = os.path.join(rootPath, folder)
    #     print(folder_path)
    #
    #     pill_folder_list = os.listdir(folder_path)
    #
    #     if folder == 'training':
    #         for pill_folder in pill_folder_list[0::2]:
    #             if pill_folder in our:
    #                 continue
    #             pill_list = f"{folder_path}/{pill_folder}"
    #             delete_list.append(pill_folder)
    #             shutil.rmtree(pill_list)
    #     else:
    #         for pill_folder in delete_list:
    #             pill_list = f"{folder_path}/{pill_folder}"
    #             delete_list.append(pill_folder)
    #             shutil.rmtree(pill_list)
    folder_path = os.path.join(rootPath, "training")
    pill_folder_list = os.listdir(folder_path)
    print(len(pill_folder_list))


check_point()











