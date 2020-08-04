import tensorflow as tf
import numpy as np

tf.linalg.svd(np.random.rand(2, 0)) # segfault