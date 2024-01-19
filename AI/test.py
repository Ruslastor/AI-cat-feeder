import numpy as np
import json
from PIL import Image

import tensorflow as tf

NETWORK_NAME = 'trained_model.h5'
IMAGE_TO_PROCESS = 'filtered_kittens/00000100_014.jpg'


model = tf.keras.models.load_model(NETWORK_NAME)

image = Image.open(IMAGE_TO_PROCESS)

x_test = np.expand_dims(np.array( [ np.asarray(image) ] ), axis=3) / 255



pionts = [int(round(i,0)) for i in model.predict(x_test)[0]*255]

print(pionts)

