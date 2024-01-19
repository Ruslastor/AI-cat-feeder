import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
import numpy as np
import matplotlib.pyplot as plt
import json
from PIL import Image

import tensorflow as tf


IMAGE_SIZE = 128
TRANING_SOURCE_DIRECTORY = 'filtrated_cats'
NETWORK_SAVING_FILE_NAME = 'trained_model.h5'


x_train, y_train  = [],[]


print('>>> started')

print('>>> creating dataset for traning...')
for file in os.listdir(os.fsencode(TRANING_SOURCE_DIRECTORY)):
    filename = os.fsdecode(file)
    if filename.endswith(".cat"):
        with open(TRANING_SOURCE_DIRECTORY+'/'+filename, 'r') as file:
            y_train.append(np.array([float(i)/IMAGE_SIZE for i in file.read().split(',')] ))  
        x_train.append(np.asarray(Image.open(TRANING_SOURCE_DIRECTORY+ '/' + filename[:-4]))/255)
y_train = np.array(y_train)
x_train = np.expand_dims(np.array(x_train), axis=3) 
print('>>> traning dataset created!')


#NETWORK ARCHITECTURE
#NETWORK ARCHITECTURE
#NETWORK ARCHITECTURE
#NETWORK ARCHITECTURE
model = tf.keras.Sequential([
    tf.keras.layers.Conv2D(32, (9, 9), padding='same', activation='relu', input_shape=(128, 128, 1)),
    tf.keras.layers.MaxPooling2D((10, 10), strides=10),
    tf.keras.layers.Conv2D(16, (5, 5), padding='same', activation='relu'),
    tf.keras.layers.MaxPooling2D((8, 8), strides=8),
    tf.keras.layers.Conv2D(8, (3, 3), padding='same', activation='relu'),
    tf.keras.layers.Flatten(),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(18, activation='linear')
])
print(model.summary())      # вывод структуры НС в консоль
#NETWORK ARCHITECTURE
#NETWORK ARCHITECTURE
#NETWORK ARCHITECTURE
#NETWORK ARCHITECTURE




#TRANING
#TRANING
#TRANING
#TRANING
model.compile(optimizer='adam', loss='mean_squared_error', metrics=['mae'])

model.fit(x_train, y_train, batch_size=32, epochs=200, validation_split=0.5)
#TRANING
#TRANING
#TRANING
#TRANING



#SAVING
#SAVING
#SAVING
#SAVING
model.save(NETWORK_SAVING_FILE_NAME)
#SAVING
#SAVING
#SAVING
#SAVING