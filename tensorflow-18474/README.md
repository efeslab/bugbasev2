# Tensorflow bug 18474
- behavior: Segmentation fault
- Affect version: tensorflowv1.4.0
- Description: Segfault on bad input to tf.constant
- sketch:
    - At tensorflow/tensorflow/python/framework/dtypes.py line 589, `if key == type_value:` using comparison between `"[,]"` cause segfault. [https://github.com/tensorflow/tensorflow/blob/81012dcd91770dc8113cd5beb4f854968c27e272/tensorflow/python/framework/dtypes.py#L589]
- Fix: tensorflow1.8.0
