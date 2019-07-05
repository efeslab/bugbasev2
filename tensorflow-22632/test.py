import tensorflow as tf
import numpy as np

data_dir, batch_size, depth, height, width = '/tmp/dataset/flowers_jpegs', 64, 3, 224, 224

def generator():
  from keras.preprocessing.image import ImageDataGenerator
  from keras.utils import OrderedEnqueuer
  gen = ImageDataGenerator(data_format='channels_first', rescale=1./255, fill_mode='nearest').flow_from_directory(
                           data_dir + '/train', target_size=(height, width), batch_size=batch_size)
  enqueuer = OrderedEnqueuer(gen, use_multiprocessing=False)
  enqueuer.start(workers=16)
  n_classes = gen.num_classes

  while True:
    batch_xs, batch_ys = next(enqueuer.get())
    yield batch_xs, batch_ys

ds = tf.data.Dataset.from_generator(generator, (tf.float32, tf.float32))
ds = ds.prefetch(buffer_size=batch_size)
ds_iter = ds.make_one_shot_iterator()


with tf.Session() as sess:
  images, labels = ds_iter.get_next()
  images = tf.reshape(images, (-1, 3, height, width))
  labels = tf.reshape(labels, (-1, 2))
  print(sess.run(images).reshape([-1])[0:8])

  images, labels = ds_iter.get_next()
  images = tf.reshape(images, (-1, 3, height, width))
  labels = tf.reshape(labels, (-1, 2))
  print(sess.run(images).reshape([-1])[0:8])