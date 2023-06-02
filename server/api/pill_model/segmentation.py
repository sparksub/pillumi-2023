from api.pill_model.util.dis_method import *
from PIL import Image
import cv2 as cv
from api.pill_model.util import ShapePreprocess

PATH = "/Users/subinpark/Development/project/pillumi-2023/server/api/pill_model/saved_models/segment-model.pth"

global segment_model


def load_segment_model():
    global segment_model
    segment_model = ISNetDIS()


def segmentation(img_path, save_path):
    segment_model.load_state_dict(torch.load(PATH))

    image_tensor, orig_size = load_image(img_path, hypar)
    mask = predict(segment_model, image_tensor, orig_size, hypar, device)

    im = Image.fromarray(mask)
    im.save('/Users/subinpark/Development/project/pillumi-2023/server/assets/mask.png')

    row_img = cv.imread(img_path)
    mask_img = cv.imread('/Users/subinpark/Development/project/pillumi-2023/server/assets/mask.png')

    row_img = ShapePreprocess.image_normalization(row_img)
    mask_img = ShapePreprocess.image_normalization(mask_img)

    mask_img = mask_img / 255
    row_img = row_img * mask_img

    cv.imwrite(save_path, row_img)



