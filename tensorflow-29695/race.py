import tensorflow as tf
import os
os.environ['CUDA_VISIBLE_DEVICES'] = ""


def generator():
    for i in range(10):
        yield [20.]


def main():
    config = tf.ConfigProto(intra_op_parallelism_threads=1,
                            inter_op_parallelism_threads=1)

    dataset = tf.data.Dataset.from_generator(
        generator,
        output_types=(tf.float32), output_shapes=(tf.TensorShape([1])))
    train_iterator = dataset.make_initializable_iterator(shared_name='g')

    with tf.Session(config=config) as session:
        session.run(train_iterator.initializer)

        data_producer = train_iterator.get_next()
        session.run(data_producer)
if __name__ == '__main__':
    main()