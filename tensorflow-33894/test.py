import tensorflow as tf
from tensorflow.core.protobuf.tensorflow_server_pb2 import ServerDef
from tensorflow.python.eager import context
from tensorflow.python.training.server_lib import ClusterSpec


cluster_def = ClusterSpec({'worker': ['127.0.0.1:15293']}).as_cluster_def()
# 15293 is just some random available port

server_def = ServerDef(
    cluster=cluster_def,
    job_name='worker',
    task_index=0,
    protocol='grpc'
)

v = tf.Variable(3)

print(v.device)
# > /job:localhost/replica:0/task:0/device:CPU:0

context.set_server_def(server_def)

####################################
print(v.device)
# > Segmentation fault (core dumped)
####################################