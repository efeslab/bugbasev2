# Tensorflow bug 22750
- behavior: Segmentation fault
- Affect version: tensorflow1.11.0-py3
- Sketch:
    - At tensorflow/core/kernels/non_max_suppression_op.cc line 277, 282, 284: ` boxes_ = context->input(0); scores_ = context->input(1); max_output_size_ = context->input(2);` where variable boxes_, scores_ and max_output_size are `Tensor&` type and member variables of class ``class NonMaxSuppressionV3V4Base : public OpKernel``. And making these member variables of the class will cause the class member to be not thread-safe, thus cause the seg fault.
    - At [https://github.com/tensorflow/tensorflow/commit/8566d9e6fa7dbe3660339befe8b0a3344d24ef2b#diff-6731fe0e9dae6d68dca55b2d50d32c06R320], change the code to the original `const Tensor& boxes = context->input(0);` like this should fix the problem.
- Fix: tensorflow:latest or use older version such as tensorflow1.9.0.
