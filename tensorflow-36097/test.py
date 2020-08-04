import numpy as np
import tensorflow as tf
from tensorflow.keras import layers

np.set_printoptions(precision=4)


class Tridiagonal(layers.Layer):
    def __init__(self):
        super(Tridiagonal, self).__init__()

    def build(self, input_shape):
        self.super = self.add_weight(shape=(input_shape[-1], 1),
                                     initializer='random_normal',
                                     trainable=True)
        self.main = self.add_weight(shape=(input_shape[-1], 1),
                                    initializer='random_normal',
                                    trainable=True)
        self.sub = self.add_weight(shape=(input_shape[-1], 1),
                                   initializer='random_normal',
                                   trainable=True)

    def call(self, inputs):
        return tf.linalg.tridiagonal_matmul(
            (self.super, self.main, self.sub), inputs,
            diagonals_format='sequence')


model = tf.keras.Sequential()
model.add(Tridiagonal())

model.compile(optimizer=tf.keras.optimizers.Adam(0.01),
              loss='mse',  # mean squared error
              metrics=['mae'])  # mean absolute error

data = tf.convert_to_tensor(np.random.random((10, 2)), dtype=tf.float32)
labels = tf.convert_to_tensor(np.random.random((10, 2)), dtype=tf.float32)

td = Tridiagonal()
td(data)