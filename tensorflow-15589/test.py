import tensorflow as tf

with tf.Session() as S: S.run( tf.get_session_handle(tf.constant(1, dtype=tf.float32)) )