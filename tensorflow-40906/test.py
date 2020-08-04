import tensorflow as tf

x = [[[3, 2, 3],
        [1, 3, 4]],

       [[3, 1, 2],
        [3, 2, 4]],

       [[4, 4, 2],
        [1, 1, 1]]]
padding = (1130323445, 1510667856)

tf.keras.backend.temporal_padding(x, padding)