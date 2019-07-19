import tensorflow as tf

################ Data
def _parse_fn2(fn, label):
    img = tf.random.uniform([224, 224, 3])
    return img, label

train_data2 = tf.data.Dataset.from_tensor_slices(
  (tf.random.uniform([100]), tf.random.uniform([100], maxval=9, dtype=tf.dtypes.int32))
)

val_data2 = tf.data.Dataset.from_tensor_slices(
  (tf.random.uniform([100]), tf.random.uniform([100], maxval=9, dtype=tf.dtypes.int32))
)
train_data2 = (train_data2.map(_parse_fn2)).batch(32)
val_data2 = (val_data2.map(_parse_fn2)).batch(32)

############### Model
IMG_SHAPE = (224, 224, 3)

base_model = tf.keras.applications.ResNet50(input_shape=IMG_SHAPE,include_top=False, weights=None)
base_model.trainable = True
maxpool_layer = tf.keras.layers.GlobalMaxPooling2D()
prediction_layer = tf.keras.layers.Dense(9, activation='softmax')

model = tf.keras.Sequential([
    base_model,
    maxpool_layer,
    tf.keras.layers.Dropout(0.4),
    prediction_layer
])

model.compile(optimizer=tf.keras.optimizers.Adam(lr=0.01), loss='categorical_crossentropy', metrics=['accuracy'])

model.summary()
history = model.fit(train_data2.repeat(),
                epochs=100,
                steps_per_epoch = 50,
                validation_data=val_data2.repeat(),
                validation_steps=10,
                class_weight={0:1,1:1,2:1,3:1,4:1,5:1,6:1,7:1,8:1,9:1},
                callbacks = [])