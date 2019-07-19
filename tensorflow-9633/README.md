# Tensorflow bug 9633
- behavior: Segmentation Fault
- Affect version: tensorflowv1.0.0
- sketch:
    - At tensorflow/tensorflow/core/kernels/sparse_tensor_dense_add_op.cc line 80, while validating requirement as sparse + dense -> dense, with dense-to-sparse broadcast.
    - At tensorflow/tensorflow/core/kernels/sparse_tensor_dense_add_op.cc line 56, `for (int i = 0; i < b->dims(); ++i)` this line dereference a invalid pointer.
- Fix: tensorflowv1.3.0
