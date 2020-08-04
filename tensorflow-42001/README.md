# Tensorflow bug41851
- Behaviour: tf.string.format is not returning Unicode characters
- Description: The problem is that the formatted tensor string is escaped:
b'\xf0\x9f\x98\x8a:"\\360\\237\\230\\212"'  ,  when a string passes through tf.strings.format unicode characters are not represented correctly.
- Error observed in tensorflow 2.2 and 2.3
- Affect version: 2.3.0
