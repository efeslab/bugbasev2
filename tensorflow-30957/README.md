# Tensorflow bug 32492
- behavior: Segmentation Fault

- description: Segfault when passing empty Tensor to cholesky_solve. When passing an empty Tensor as the second argument to the `tf.cholesky_solve` function a segfault is encountered.

- Affect version: tensorflow:1.14.0