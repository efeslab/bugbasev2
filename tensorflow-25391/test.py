import tensorflow as tf
tf.enable_eager_execution()
# This is ok
tf.linalg.solve([[.1, .0], [.0, .1]], [[.1], [.1]])
# This line causes segfault
tf.linalg.solve([[.1, .0], [.0, .1]], [.1, .1])