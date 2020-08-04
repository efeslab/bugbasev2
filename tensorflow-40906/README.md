# Tensorflow bug-40906
- Behaviour: Segmentation fault / Core Dumped

- Description: Segfault occurs when passing the tuple of large values for padding in `tf.keras.backend.temporal_padding()`     

- Affect version: tensorflow:2.2.0
