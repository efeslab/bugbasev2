import tensorflow as tf
import numpy as np

def gen_one_hot(sess, h, w, input_dtype, one_hot_axis):
    mat = np.random.rand(h, w) * 10
    # matt has shape [h, w]
    matt = tf.constant(mat, input_dtype, shape=mat.shape)
    matt_oh = tf.one_hot(matt, depth=10, axis=one_hot_axis)
    print (sess.run(matt_oh).shape)
    
def gen_one_hot_1d(sess, l, dtype, axis):
    mat = np.random.rand(l) * 10
    # matt has shape [l]
    matt = tf.constant(mat, dtype, shape=mat.shape)
    matt_oh = tf.one_hot(matt, depth=10, axis=axis)
    print (sess.run(matt_oh).shape)

if __name__ == '__main__':
    sess = tf.Session()
    
    # 1d test
    
    gen_one_hot_1d(sess, 256, tf.int32, -1)   # works
    gen_one_hot_1d(sess, 256, tf.int32, 0)    # works
    gen_one_hot_1d(sess, 256, tf.int32, 1)    # works
    
    gen_one_hot_1d(sess, 255, tf.uint8, -1)   # works
    gen_one_hot_1d(sess, 255, tf.uint8, 0)    # works
    gen_one_hot_1d(sess, 255, tf.uint8, 1)    # works
    
    gen_one_hot_1d(sess, 256, tf.uint8, -1)   # works
    gen_one_hot_1d(sess, 256, tf.uint8, 0)    # crash
    gen_one_hot_1d(sess, 256, tf.uint8, 1)    # works

    # 2d test, axis = -1
    
    gen_one_hot(sess, 255, 255, tf.int32, -1) # works
    gen_one_hot(sess, 255, 256, tf.int32, -1) # works
    gen_one_hot(sess, 256, 255, tf.int32, -1) # works
    gen_one_hot(sess, 256, 256, tf.int32, -1) # works
    
    gen_one_hot(sess, 255, 255, tf.uint8, -1) # works
    gen_one_hot(sess, 255, 256, tf.uint8, -1) # works
    gen_one_hot(sess, 256, 255, tf.uint8, -1) # works
    gen_one_hot(sess, 256, 256, tf.uint8, -1) # works
    
    # 2d test, axis = 0
    
    gen_one_hot(sess, 255, 255, tf.int32, 0)  # works
    gen_one_hot(sess, 255, 256, tf.int32, 0)  # works
    gen_one_hot(sess, 256, 255, tf.int32, 0)  # works
    gen_one_hot(sess, 256, 256, tf.int32, 0)  # works
    
    gen_one_hot(sess, 255, 255, tf.uint8, 0)  # crash
    gen_one_hot(sess, 255, 256, tf.uint8, 0)  # crash
    gen_one_hot(sess, 256, 255, tf.uint8, 0)  # crash
    gen_one_hot(sess, 256, 256, tf.uint8, 0)  # crash
    
    # 2d test, axis = 1
    
    gen_one_hot(sess, 255, 255, tf.int32, 1)  # works
    gen_one_hot(sess, 255, 256, tf.int32, 1)  # works
    gen_one_hot(sess, 256, 255, tf.int32, 1)  # works
    gen_one_hot(sess, 256, 256, tf.int32, 1)  # works

    gen_one_hot(sess, 255, 255, tf.uint8, 1)  # works
    gen_one_hot(sess, 255, 256, tf.uint8, 1)  # crash
    gen_one_hot(sess, 256, 255, tf.uint8, 1)  # works
    gen_one_hot(sess, 256, 256, tf.uint8, 1)  # crash