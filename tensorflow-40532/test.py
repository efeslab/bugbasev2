import tensorflow as tf

boxes = [[4.0, 6.0, 3.0, 6.0],
       [2.0, 1.0, 5.0, 4.0],
       [9.0, 0.0, 9.0, 9.0]]
scores = [5.0, 6.0, 5.0]
max_output_size = 1000000000000

tf.image.non_max_suppression_padded(
   boxes, scores, max_output_size, iou_threshold=0.5,
    score_threshold=float('-inf'), pad_to_max_output_size=True, name=None)
