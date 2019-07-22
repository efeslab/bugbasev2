# Tensorflow bug8338
- Behaviour: Segmentation fault / Core Dumped
- Description: Segmentation Fault (core dumped) on exit from multiple `sample().eval()` calls.
- Affect version: 1.0.1
- Failure Sketch:
    * It only happens when EOF is reached (i.e. exit() from python), and `tf.contrib.distributions` cause memory corruption.
    * The actual backtrace code is unrelated, but this bug can be solved by `pip install --no-binary=:all: numpy`. 
- Fixed version: tensroflow:latest or `pip install --no-binary=:all: numpy`