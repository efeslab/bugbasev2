import numpy as np
import tensorflow as tf


def go():

    with tf.Graph().as_default():

        with tf.Session() as sess:

            X = tf.placeholder(shape=None, dtype=tf.float64)

            rhs = X[1:]
            rhs = tf.reshape(rhs, shape=(-1, 1))

            chol = tf.ones(shape=(1, 1), dtype=tf.float64)

            iP0 = tf.cholesky_solve(chol, rhs)

            feed_dict = {X: np.asarray([1.])}
            print(sess.run(iP0, feed_dict=feed_dict))

            print('SUCCESS!')


go()