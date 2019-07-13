import tensorflow as tf

DATASET_SIZE = 4
SAVE_STEPS = 2
TRAIN_STEP = 3
CHECKPOINT_DIR = '/tmp/tf_dataset_saveable'

def test_saveable():
    """test saveable"""
    graph = tf.Graph()
    with graph.as_default():
        dataset = tf.data.Dataset.range(DATASET_SIZE).repeat()
#        dataset_iterator = dataset.make_one_shot_iterator()
        dataset_iterator = dataset.make_initializable_iterator()
        dataset_init = dataset_iterator.initializer
        data = dataset_iterator.get_next()

        saveable = tf.contrib.data.make_saveable_from_iterator(dataset_iterator)
        tf.add_to_collection(tf.GraphKeys.SAVEABLE_OBJECTS, saveable)

        global_step = tf.train.get_or_create_global_step()
        inc_global_step = tf.assign_add(global_step, 1)  # critical

        saver = tf.train.Saver()
        checkpoint_dir = CHECKPOINT_DIR
        scaffold = tf.train.Scaffold(saver=saver)
        checkpoint_hook = tf.train.CheckpointSaverHook(
            checkpoint_dir=checkpoint_dir,
            save_steps=SAVE_STEPS, scaffold=scaffold)

        hooks = [checkpoint_hook]
        session_creator = tf.train.ChiefSessionCreator(
            scaffold=scaffold, checkpoint_dir=checkpoint_dir)
        with tf.train.MonitoredSession(
                session_creator=session_creator, hooks=hooks) as mon_sess:
            gstep = mon_sess.run(global_step)
            if not gstep:
                mon_sess.run(dataset_init)
            for _ in range(TRAIN_STEP):
                print(mon_sess.run([global_step, data]))
                mon_sess.run(inc_global_step)

if __name__ == '__main__':
    test_saveable()