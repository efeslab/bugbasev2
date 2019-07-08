import numpy as np
import tensorflow as tf

num_dim = 20
FORMAT = tf.float64 #32 or 64 does not matter
n = 3500 #reducing the number results in normal execution

def simpeLoop(alpha):
      i = tf.constant(0)
      m0 = tf.zeros([num_dim, 1], dtype=FORMAT)
      cond = lambda i, m: i < n
      def body(ic, vec): 
            #a meaningless example, summing up the first num_dim elements of a vector 
            op = alpha[ic * num_dim:(ic + 1) * num_dim, :]
            # with tf.control_dependencies([op]): #if you uncomment this, it will not fault!
            return ic + 1, vec + op
      loop = tf.while_loop(cond, body, [i, m0], parallel_iterations=10**4, back_prop=False)
      return loop[1]

with tf.device('/cpu:0'):
      alpha = tf.placeholder(FORMAT, [None, 1], name="alpha")
      fdict = {
          alpha: np.random.rand(n * num_dim, 1),
      }
      op = simpeLoop(alpha)
      op = tf.reduce_sum(op) #not necessary for the seg fault
      init = tf.global_variables_initializer()

config = tf.ConfigProto()
threads = 1
config.intra_op_parallelism_threads = threads
config.inter_op_parallelism_threads = threads
sess = tf.Session(config=config)
sess.run(init, feed_dict=fdict)
print("init")
print(sess.run(op, feed_dict=fdict))