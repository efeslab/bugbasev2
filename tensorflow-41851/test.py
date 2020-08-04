from __future__ import print_function

from tensorflow.keras.datasets import mnist
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.optimizers import RMSprop
from tensorflow.keras.callbacks import Callback, ModelCheckpoint, History
from tensorflow.keras import utils
from sklearn import metrics

batch_size = 128
num_classes = 10
epochs = 2

# Custom callback, where the logs are actually the numpy_logs object 
# if the flag self._supports_tf_logs is not set to True
class CustomMetric(Callback):
    def __init__(self, x_valid, y_valid):
        super().__init__()
        self.x_valid = x_valid
        self.y_valid = y_valid

    def on_epoch_end(self, epoch, logs=None):
        y_pred = self.model.predict(self.x_valid, batch_size=batch_size)

        logs['val_log_loss'] = metrics.log_loss(self.y_valid, y_pred)


# the data, split between train and test sets
(x_train, y_train), (x_test, y_test) = mnist.load_data()

x_train = x_train.reshape(60000, 784).astype('float32') / 255.
x_test = x_test.reshape(10000, 784).astype('float32') / 255.

# convert class vectors to binary class matrices
y_train = utils.to_categorical(y_train, num_classes)
y_test = utils.to_categorical(y_test, num_classes)

model = Sequential()
model.add(Dense(64, activation='relu', input_shape=(784,)))
model.add(Dense(32, activation='relu'))
model.add(Dense(num_classes, activation='softmax'))

model.summary()

model.compile(loss='categorical_crossentropy',
              optimizer=RMSprop(),
              metrics=['accuracy'])

# The following part works partly as intended.
# history.history contains the key 'val_log_loss' even though it is not printed by the ProgbarLogger
# (since ProgbarLogger uses logs and CustomMetric numpy_logs)
history = model.fit(x_train, y_train,
                    batch_size=batch_size,
                    epochs=epochs,
                    verbose=1,
                    validation_data=(x_test, y_test),
                    callbacks=[
                        CustomMetric(x_test, y_test)
                    ])

print(history.history)

# This following part does not work as intented.
# ModelCheckpoint outputs the warning
# "WARNING:tensorflow:Can save best model only with val_log_loss available, skipping."
# because 'val_log_loss' is in the numpy_logs object and ModelCheckpoint uses the logs object
model.fit(x_train, y_train,
          batch_size=batch_size,
          epochs=epochs,
          verbose=1,
          validation_data=(x_test, y_test),
          callbacks=[
              CustomMetric(x_test, y_test),
              ModelCheckpoint('test.h5', monitor='val_log_loss', verbose=1, save_best_only=True, mode='min')
          ])
