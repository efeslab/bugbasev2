from tensorflow.python.ops import nn_ops
import tensorflow as tf
import numpy as np

images = np.ones((1,1,15,1)).astype(np.float32)
filters = 1 * np.ones((1,1,1,1), np.float32)

with tf.Session(''):
  output = nn_ops.conv2d(
      images,
      filters,
      strides=[1,1,1,1],
      padding='VALID',
      data_format='NCHW',
  ).eval()