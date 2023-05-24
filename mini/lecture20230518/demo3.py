import pickle
import numpy as np
import matplotlib.pyplot as plt
import tensorflow as tf

# to load data
mnist_file = open('mnist_data.pickle', 'rb')
mnist_data = pickle.load(mnist_file)
mnist_file.close()

# to clean data
(x_train, y_train), (x_test, y_test) = mnist_data
x_train, x_test = x_train / 255.0, x_test / 255.0

# to construct model
model = tf.keras.models.Sequential([
    tf.keras.layers.Flatten(input_shape=(28, 28)),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dropout(0.2),
    tf.keras.layers.Dense(10, activation='softmax')
])

model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

# to fit model
model.fit(x_train, y_train, epochs=5)
# to predict
predictions = model.predict(x_test)

# to print the performance of the fitted model
print(model.evaluate(x_test, y_test))

# to show first 10 predictions
print("Test: ", [np.argmax(predictions[i]) for i in range(10)])
plt.figure(figsize=(10, 10))
for i in range(10):
    plt.subplot(5, 5, i+1)
    plt.xticks([])
    plt.yticks([])
    plt.grid(False)
    plt.imshow(x_test[i], cmap=plt.cm.binary)
plt.show()
