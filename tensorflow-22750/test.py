import tensorflow as tf
import numpy as np

def f(boxes, scores):
    def f(X):
        prob, box = X
        output_shape = tf.shape(prob)
        ids = tf.reshape(tf.where(prob > 0.05), [-1])
        prob = tf.gather(prob, ids)
        box = tf.gather(box, ids)
        # prob = tf.Print(prob, [box, prob], summarize=100, message='boxandprob')
        selection = tf.image.non_max_suppression(box, prob, 100, 0.5)
        selection = tf.to_int32(tf.gather(ids, selection))
        selection = tf.Print(selection, [ids, selection], summarize=100, message='ids_selection_2')
        sorted_selection = -tf.nn.top_k(-selection, k=tf.size(selection))[0]
        mask = tf.sparse_to_dense(
            sparse_indices=sorted_selection,
            output_shape=output_shape,
            sparse_values=True,
            default_value=False)
        return mask

    masks = tf.map_fn(f, (scores, boxes), dtype=tf.bool, parallel_iterations=10)     # #cat x N
    return masks

with tf.device('/gpu:0'):
    boxes = tf.placeholder(tf.float32, (80, None, 4), name='boxes')
    scores = tf.placeholder(tf.float32, (80, None), name='scores')
    outs = f(boxes, scores)

config = tf.ConfigProto()
config.allow_soft_placement = True
sess = tf.Session(config=config)
data = dict(np.load('debug.npz'))
for k in range(1000):
    sess.run(outs, feed_dict={boxes: data['boxes'].transpose(1, 0, 2)[1:, :, :], scores: data['scores'][:, 1:].T})
    print(k)