import tensorflow as tf
l = [
     [[0.6,  0  , 0],
      [0.2,  0.5, 0],
      [0.1, -0.3, 0.4],
     ],
     [[0.6,  0  , 0],
      [0.2,  0.5, 0],
      [0.1, -0.3, 0.4],
     ],
    ] # insert here the tensor that got printed
l = tf.linalg.triangular_solve(l, tf.eye(3))