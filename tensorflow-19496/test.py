import tensorflow as tf
from tensorflow.contrib.rpc.python.ops.gen_rpc_op import try_rpc
tf.enable_eager_execution()
response = try_rpc('localhost:80', '/Test', 'some simple message', protocol='grpc')