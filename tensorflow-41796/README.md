# Tensorflow bug 41796
- Behaviour: the shared network inside a compiled keras model got modified after resetting the trainable attribute of the shared network

- Affect version: 2.3.0
- TensorFlow version: 2.3.0
     
- Current behavior
	I would like to do domain-translation with three domains with gan. But I found the shared network got modified although my model has been compiled.
