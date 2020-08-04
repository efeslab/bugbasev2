# tensorflow-40175
- behavior: Segmentation Fault

- description: `tf.summary.flush` segfaults when writer is not a valid `tf.summary.SummaryWriter` object. This is because, `tf.summary.flush` doesn't have input validity check to ensure writer is a `tf.summary.SummaryWriter`

- Affect version: tensorflow:2.1.0,2.2.0