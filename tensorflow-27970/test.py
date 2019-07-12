import tensorflow as tf
from tensorflow.contrib.compiler.xla import compile
import numpy as np

LABELS = 10
HIDDEN_SIZE = 256
BATCH_SIZE = 64
FEAT_DIM = 784

xla_flag = True


def model_fn(features, labels):
  with tf.variable_scope("fc", use_resource=True):
    net = tf.keras.layers.Dense(units=HIDDEN_SIZE,
                                activation=tf.nn.relu)(features)
    logits = tf.keras.layers.Dense(units=LABELS)(net)
    cross_entropy = tf.reduce_mean(
      tf.nn.softmax_cross_entropy_with_logits(labels=labels,
                                              logits=logits))
    global_step = tf.train.get_or_create_global_step()
    boundaries = [100000, 110000]
    values = [1.0, 0.5, 0.1]
    learning_rate = tf.train.piecewise_constant_decay(global_step, boundaries, values)
    train_step = tf.train.GradientDescentOptimizer(
      learning_rate, name="final_node").minimize(cross_entropy)
    with tf.control_dependencies([train_step]):
      return tf.identity(cross_entropy, name="results")

x = tf.placeholder(tf.float32, [BATCH_SIZE, FEAT_DIM], name='x')
y = tf.placeholder(tf.float32, [BATCH_SIZE, LABELS], name='y')

if xla_flag:
  (xla_loss,) = compile(model_fn, [x,y])
else:
  xla_loss = model_fn(x,y)

with tf.Session() as sess:
  sess.run(tf.initialize_all_variables())
  ans = sess.run(xla_loss,feed_dict={x:np.ones((BATCH_SIZE,FEAT_DIM)),y:np.ones((BATCH_SIZE,LABELS))})
