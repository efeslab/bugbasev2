import tensorflow as tf
import numpy as np
tf.summary.flush(writer=np.random.rand(2,2)) # causes segfaults