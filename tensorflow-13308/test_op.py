import numpy as np
import tensorflow as tf

mod = tf.load_op_library("./tfop.so")
d = mod.zero_out(tf.ones(100, dtype=tf.int32))

init_op = tf.global_variables_initializer()

with tf.Session() as S:
    S.run(init_op)
    print S.run(d)
