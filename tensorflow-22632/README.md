# Tensorflow bug 22632
- behavior: Race condition / Deadlock (The program hangs and cannot be ended even with ctrl + c)
- Affect version: tensorflowv1.12.0
- sketch:
    - Wait to be added.
- Fix: The bug session was closed becasue tf.data.Dataset.from_generator is not a good choice for HP training. 
