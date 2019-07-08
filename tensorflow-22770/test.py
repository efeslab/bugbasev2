import sys
import numpy
import tensorflow as tf
from tensorflow.python.ops.nn import rnn_cell
import contextlib
import atexit
import gc
import faulthandler
import better_exchook


@contextlib.contextmanager
def make_scope():
  """
  :rtype: tf.Session
  """
  with tf.Graph().as_default() as graph:
    with tf.Session(graph=graph) as session:
      yield session


class Dummy:
  def __del__(self):
    print("Dummy Goodbye")


def test():
  dummy = Dummy()
  random = numpy.random.RandomState(seed=1)
  num_inputs = 4
  num_outputs = 3
  seq_len = 10
  limit = 1.0

  with make_scope() as session:
    print("create graph")
    tf.set_random_seed(42)
    src_placeholder = tf.placeholder(tf.float32, (None, seq_len, num_inputs), name="src_placeholder")
    tgt_placeholder = tf.placeholder(tf.float32, (None, seq_len, num_outputs), name="tgt_placeholder")

    def make_feed_dict():
      return {
        src_placeholder: random.uniform(-limit, limit, (1, seq_len, num_inputs)),
        tgt_placeholder: random.uniform(-limit, limit, (1, seq_len, num_outputs)),
      }

    with tf.variable_scope(tf.get_variable_scope()) as scope:
      x = tf.get_variable("b", shape=(seq_len, 1, num_outputs * 2))
      input_ta = tf.TensorArray(tf.float32, size=seq_len, element_shape=(None, num_outputs * 2))
      # The existence (and non-usage) of the TensorArray unstack triggers the crash.
      input_ta = input_ta.unstack(x)
      loss = tf.reduce_sum(x ** 2)
    optimizer = tf.train.AdamOptimizer(learning_rate=0.1, epsilon=1e-16, use_locking=False)
    minimize_op = optimizer.minimize(loss)
    check_op = tf.no_op()

    print('variables:')
    train_vars = (
            tf.trainable_variables() +
            tf.get_collection(tf.GraphKeys.TRAINABLE_RESOURCE_VARIABLES))
    print(train_vars)
    print('init vars')
    session.run(tf.global_variables_initializer())
    print('graph size:', session.graph_def.ByteSize())
    print('train')
    for s in range(1):
      loss_val, _, _ = session.run([loss, minimize_op, check_op], feed_dict=make_feed_dict())
      print("step %i, loss: %f" % (s, loss_val))

  # Demo.
  try:
    raise Exception("foo")
  except Exception:
    sys.excepthook(*sys.exc_info())

  # This would avoid the crash:
  # gc.collect()


def at_exit_handler():
  print("atexit handler")
  # Demo:
  try:
    raise Exception("foo")
  except Exception:
    sys.excepthook(*sys.exc_info())


if __name__ == "__main__":
  atexit.register(at_exit_handler)
  better_exchook.install()
  better_exchook.replace_traceback_format_tb()
  faulthandler.enable()
  test()
  print("Exit.")