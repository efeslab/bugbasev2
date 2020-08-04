# Tensorflow bug 41973
- Behaviour: SavedModel exporting fails on RNNs by setting wrong input dtypes
- Output : Assertion Error
     If the assertion is removed, this line fails with:
     TypeError: Value passed to parameter 'indices' has DataType float32 not in list of allowed values: int32, int64
- Affect version: 2.3.0
- Desc:
	TensorFlow installed from: binary
	TensorFlow version: 2.3.0
	Python version: 3.7.7
     
- Current behavior
	When trying to export concrete functions in a Keras model to the SavedModel format, if a function uses tf.keras.layers.RNN, the dtypes of the RNN cell input arguments are wrong. In particular, actual dtypes seem to be ignored and replaced with tf.float32. This does not happen when calling the same concrete function manually, but only when trying to export it.
- Expected behavior
	The input dtypes should be preserved, allowing to export the model. At the very least the behavior should be consistent with calling the concrete function.