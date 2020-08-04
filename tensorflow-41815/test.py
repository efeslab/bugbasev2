import tensorflow as tf

class TestRNNCell(tf.keras.layers.Layer):
  def __init__(self):
    super().__init__()
    self.units = 10
    self.state_size = 20

  def call(self, indices, state):
    # This assertion fails.
    assert indices.dtype == tf.int32
    # If the assertion is removed, this line fails with:
    # TypeError: Value passed to parameter 'indices' has DataType float32 not in list of allowed values: int32, int64
    output = tf.gather(tf.range(5), indices)
    return output, state

class TestModel(tf.keras.Model):
  def __init__(self):
    super().__init__()
    self.rnn = tf.keras.layers.RNN(TestRNNCell())

  @tf.function
  def do_stuff(self, indices):
    assert indices.dtype == tf.int32
    return self.rnn(indices)

model = TestModel()
tf.saved_model.save(model, 'test_model', signatures={
  'do_stuff': model.do_stuff.get_concrete_function(
      indices=tf.TensorSpec([None, None, 5], tf.int32))
})