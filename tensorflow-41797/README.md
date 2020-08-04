# Tensorflow bug 41797
- Behaviour: Keras saves invalid JSON files containing Infinity

- Affect version: 2.2.0
- Desc:
	TensorFlow installed from: binary
	TensorFlow version: 2.3.0
	Python version: 3.7.7
     
- Current behavior
	JSON saved by Keras contains Infinity which is invalid according to RFC 7159:

    "Numeric values that cannot be represented in the grammar below (such as Infinity and NaN) are not permitted."

- Expected behavior
	Keras saves correct JSON format.