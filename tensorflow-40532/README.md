# Tensorflow bug 40532
- behavior: Segmentation Fault

- description: Segmentation fault occurs when passing a large value  max_output_size and True for pad_to_max_output_size in `tf.image.non_max_suppression_padded()`

- Affect version: tensorflow:2.2.0
