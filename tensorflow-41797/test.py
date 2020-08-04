from tensorflow import keras
input = keras.Input(shape=(1))
x = keras.backend.sqrt(input)
model = keras.Model(input, x)
model.compile(optimizer='adam', loss='mse')
with open('repro.json', 'w') as json_file:
    json_file.write(model.to_json())