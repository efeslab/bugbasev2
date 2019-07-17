import tensorflow as tf
def test(buffer_size):
    ds = tf.data.Dataset.range(5)
    ds = ds.prefetch(buffer_size=buffer_size)
    iterator = ds.make_one_shot_iterator()
    entry = iterator.get_next()
    with tf.Session() as sess:
        try:
            while True:
                print(sess.run(entry))
        except tf.errors.OutOfRangeError:
            pass
        
test(1)
test(0)  # deadlock