import tensorflow as tf
import os

a = tf.get_variable('W', shape=[1,1,256,60], dtype=tf.float32)

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    saver = tf.train.Saver()
    saver.save(sess, './model')

os.remove('model.data-00000-of-00001')

with tf.Session() as sess:
    saver = tf.train.Saver()
    saver.restore(sess, './model')