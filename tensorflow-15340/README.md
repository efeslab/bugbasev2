# Tensorflow bug15340
- Behaviour: Deadlock / Race condition
- Description: StagingArea.get() ignores timeout and 
- Affect version: 1.8.0
- Failure sketch:
    * The `get()` method of a `tf.contrib.staging.StagingArea` at tensorflow/tensorflow/python/ops/data_flow_ops.py line 1858 is a blocking operation. And it does not raise a timeout and deadlocks.
- Fixed version: tensorflow:latest