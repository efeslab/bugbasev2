# Tensorflow bug14623
- Behaviour: tf.while_loop creates segmentation fault
- Affect version: 1.3 / 1.4
- Failure sketch:
	* From official documentation, `The maximum number of parallel iterations can be controlled by parallel_iterations, which gives users some control over memory consumption and execution orde`.
	* ```tf.while_loop(cond, body, [i, m0], parallel_iterations=10**4, back_prop=False)``` where parallel_iterations is set to a large value would cause a seg fault.
- Fixed version: 1.5 and after