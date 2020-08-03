import numpy as np
import tensorflow
from tensorflow import keras
from tensorflow.keras import layers
import gc
import tracemalloc    
if __name__ == "__main__":
    tracemalloc.start()
    while True:
        inputs = keras.Input(shape=(10,))
        out = layers.Dense(1)(inputs)
        model = keras.Model(inputs=inputs, outputs=out)
        model.compile(optimizer="adam", loss="mse")
        train = np.random.rand(1000,10)
        label = np.random.rand(1000)
        model.fit(train, label)
        gc.collect()
        current, peak = tracemalloc.get_traced_memory()
        print(f"Current memory usage is {current / 10**6}MB; Peak was {peak / 10**6}MB")