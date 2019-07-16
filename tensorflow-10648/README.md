# Tensorflow bug10648
- Behaviour: Segmentation fault / Core Dumped
- Description: Segmentation Fault (core dumped) on exit from unit test that imports `tf.contrib.rnn`
- Affect version: 1.0.0
- Failure Sketch:
	* This only happens when the test have a custom directory tests and the example_test.py file is inside the directory. If the tests directory is empty, the test will return with OK.
	* The `session` is created as a reference to `tf.contrib.rnn`, it is very possible that the object is destructed when session is still in use. The exact code fragment need to be updated.
- Fixed version: tensroflow:latest