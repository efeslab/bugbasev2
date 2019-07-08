import tensorflow as tf
extr_module = tf.load_op_library('./build/libextr_module.so')

dummy = extr_module.test_bug()

with tf.Session() as sess:
    sess.run([dummy])