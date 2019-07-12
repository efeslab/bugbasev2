# Tensorflow bug 26099
- behavior: Segmentation fault / Aborted
- Affect version: tensorflow1.12.0
- description: tf.one_hot crashes when indices is tf.uint8
- sketch:
    - /tensorflow/core/framework/tensor.h:663] Check failed: new_num_elements == NumElements() (0 vs. 256)
- Fix: 
