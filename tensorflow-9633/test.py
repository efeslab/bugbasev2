from __future__ import print_function

import numpy as np
import tensorflow as tf

dense_sz = [1, 1000, 1000]
dense = tf.constant(1.0, shape=dense_sz, dtype=tf.float32)

sparse_sz = [10, 1000, 1000]
nnz = 100
nz_ind = np.random.choice(np.prod(sparse_sz), size=nnz, replace=False)
nz_ind = np.unravel_index(nz_ind, dims=sparse_sz)
nz_ind = np.array(nz_ind).T
assert np.all(nz_ind < np.array(sparse_sz)[None, :])
# Ensure canonical ordering.
ind = np.lexsort([nz_ind[:, i].flatten() for i in reversed(range(nz_ind.shape[1]))])
nz_ind = nz_ind[ind, :]
print('nz_ind\n', nz_ind)

sparse_plc = tf.sparse_placeholder(tf.float32)
sparse_sum = tf.sparse_add(dense, sparse_plc)
init = tf.global_variables_initializer()

with tf.Session() as sess:
    sess.run(init)
    print('after init')
    res = sess.run(sparse_sum, feed_dict={sparse_plc: tf.SparseTensorValue(nz_ind, np.ones((nnz,)), sparse_sz)})
    print('sum\n', res)
