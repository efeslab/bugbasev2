import tensorflow as tf
from tensorflow.keras.layers import Input

print(tf.__version__)

input_ = Input((128, 128, 1), dtype='float32')
print(input_)
output = tf.stack(input_, axis=1)