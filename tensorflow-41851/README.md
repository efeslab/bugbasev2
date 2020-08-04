# Tensorflow bug41851
- Behaviour: Keras Callbacks logs / numpy_logs not in sync
- Description: Some callbacks (e.g. ProgbarLogger, ModelCheckpoint, ...) have the flag self._supports_tf_logs = True. If other callbacks (especially custom Callback) don't have this property, then those callbacks do not have acces to the same logs.
In the code example below, ModelCheckpoint can not use the 'val_log_loss' as a monitor value from the CustomMetric callback.
- Affect version: 2.3.0
- OS Platform and Distribution : Windows 10
- TensorFlow installed from (source or binary): binary
- Python version: 3.6.8
