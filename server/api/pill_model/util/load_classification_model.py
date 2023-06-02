import pandas as pd
import tensorflow as tf


def load_classification_model():
    global shape_model
    global print_model

    shape_model = tf.keras.models.load_model('api/pill_model/model/classification/shape_simplecnn.h5')
    print_model = tf.keras.models.load_model('api/pill_model/model/classification/print_simplecnn.h5')

