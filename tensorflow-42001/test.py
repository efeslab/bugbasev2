import tensorflow as tf

print(tf.constant('😊:😊').numpy().decode('utf-8')) # output: 😊:😊
print(tf.strings.format("😊:{}", tf.constant('😊')).numpy().decode('utf-8')) # output: 😊:"\\360\\237\\230\\212" 