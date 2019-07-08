import numpy as np
import tensorflow as tf

sample = np.zeros((1, 41, 960, 1280, 1))
label = np.zeros((1,))

rc_kernel = np.ones((31,))

x = tf.placeholder(tf.float64, shape=[None, 41, 960, 1280, 1])
y_ = tf.placeholder(tf.float64, shape=[None])

W_conv_r = tf.Variable(rc_kernel.reshape((1, -1, 1, 1, 1)))
h_blur = tf.nn.conv3d(x, W_conv_r, [1, 1, 1, 1, 1], "VALID")

h_sum = tf.reduce_sum(tf.reduce_sum(tf.reduce_sum(h_blur, axis=3), axis=2), axis=1)
y = tf.sigmoid(h_sum)

sq_err = (y - y_) ** 2

train_step = tf.train.GradientDescentOptimizer(0.1).minimize(sq_err)

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    E = sq_err.eval(feed_dict={x: sample, y_: label})
    train_step.run(feed_dict={x: sample, y_: label})  # fails here
    print('ran train step')