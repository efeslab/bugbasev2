import tensorflow as tf
import numpy as np
import random
from math import floor
import tensorflow_estimator
import pandas as pd
from Libs import DBLib
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler
from time import time
from tensorflow.python import debug as tf_debug


class NeuralNetwork:

    def __init__(self):
        self.learning_rate = 0.1
        self.epochs = 1000
        self.batch_size = 350
        self.profiler = None
        self.scaler = MinMaxScaler(feature_range=(-1, 1))

    def make_data(self,n=100):
        x = {"a":[],"b":[],"c":[]}
        y = {"0":[]}
        for i in range(n):
            l = []
            for ii in ["a","b","c"]:
                ri = random.randint(0,1)
                x[ii].append(float(ri))
        for e in range(n):
            l = [x["a"][e],x["b"][e],x["c"][e]]
            if l[0] == 1:
                if l[1] == 1:
                    y["0"].append(0)
                else:
                    y["0"].append(1)
            else:
                y["0"].append(0)
        return x,y

    def build_nn_with_keras_functional_api(self):
        sess = tf.keras.backend.get_session()
        sess = tf_debug.LocalCLIDebugWrapperSession(sess, "rhino:6064")
        tf.keras.backend.set_session(sess)
        x, y = self.make_data(1000)
        x = pd.DataFrame(x)
        y = pd.DataFrame(y)
        test_x, test_y = self.make_data(200)
        test_x = pd.DataFrame(test_x)
        test_y = pd.DataFrame(test_y)
        inputs = tf.keras.Input(shape=(3,))
        layer1 = tf.keras.layers.Dense(3, activation="relu")(inputs)
        layer2 = tf.keras.layers.Dense(3, activation="relu")(layer1)
        output = tf.keras.layers.Dense(1, activation=tf.nn.sigmoid)(layer2)
        model = tf.keras.Model(inputs=inputs, outputs=output)
        model.compile(optimizer=tf.train.GradientDescentOptimizer(learning_rate=self.learning_rate), loss="mse",
                      metrics=["accuracy"])
        model.fit(x, y, batch_size=self.batch_size, epochs=20, steps_per_epoch=100)
        print("evaluation")
        eval_result = model.evaluate(test_x, test_y, batch_size=self.batch_size)
        print(eval_result)
        newx, y = self.make_data(10)
        newx = pd.DataFrame(newx)
        y = pd.DataFrame(y)
        predictions = model.predict(newx, batch_size=self.batch_size)
        for i, row in y.iterrows():
            print(row["0"], predictions[i])
        print(model.input_names)
        return model

if __name__ == '__main__':
    NN = NeuralNetwork()
    NN.build_nn_with_keras_functional_api()
