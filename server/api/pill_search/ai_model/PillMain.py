import api.pill_search.ai_model.PillModel as PillModel
import shutil
import configparser


class PillMain():

    def main(self, argv):
        image1_path = argv[0]
        image2_path = argv[1]
        drug_list = 'none'

        config_file = 'api/pill_search/ai_model/config_etc.ini'
        config = configparser.ConfigParser()

        config.read(config_file, encoding='UTF-8')
        pillModel = PillModel.PillModel(config['pill_model_info'])

        # image processing
        # print(image1_path, image2_path)
        pillModel.pill_image_process(image1_path)
        pillModel.pill_image_process(image2_path)

        # image open
        img = pillModel.testImage(config['pill_model_info']['make_folder_path'])

        # model loading
        pillModel.pill_shape_conf()
        pillModel.pill_model_loading(config['pill_model_info'])

        # prediction
        output = pillModel.pill_prediction(img)
        indices_top, includ_count = pillModel.pill_sorting(output, drug_list)

        print(pillModel.pill_information(indices_top))

        # remove filter image folder
        # shutil.rmtree("api/pill_search/ai_model/data/filter_folder/")

        return pillModel.pill_information(indices_top)
