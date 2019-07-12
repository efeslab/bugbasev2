# Tensorflow bug 26099
- behavior: Segmentation fault / Aborted
- Affect version: tensorflow1.12.0
- description: tf.one_hot crashes when indices is tf.uint8
- sketch:
    - /tensorflow/core/framework/tensor.h:663 Check failed: ```new_num_elements == NumElements() (0 vs. 256)```
    - Definition of class tensor member function ```NumElements()``` is ```int64 NumElements() const { return shape().num_elements(); }``` which is interpreted as a int64 type. 
    - ```CHECK_EQ(new_num_elements, NumElements());``` at /tensorflow/core/framework/tensor.h:663 check the equality between *int8* type value 256(which is 0) and *int64* type value 256(which is 256), and thus cause the error.
- Fix: convert the check ```NumElements()``` return value to be a int8 value as well. 
