# Tensorflow bug10338
- Behaviour: Segmentation fault / Core Dumped
- Description: Segmentation Fault (core dumped) when start tf.session with cuda8.0
- Affect version: 1.1.0
- Failure Sketch:
	* Error in `python3': free(): invalid pointer: 0x00007f28329efac0`
	* `/usr/local/lib/python3.5/dist-packages/tensorflow/python/_pywrap_tensorflow_internal.so(_ZN10tensorflow20BaseGPUDeviceFactory17GetValidDeviceIdsERKSsPSt6vectorIiSaIiEE+0x7c7)[0x7f27fb0a8127]`
	* The problem occurs only with import order in test.py
- Fixed version: tensroflow:latest / cuda9.0