from sklearn.model_selection import train_test_split
import glob
import os
import shutil

imgs = []
labels = []
extensions = ['jpg', 'png', 'bmp', 'jpeg', 'gif']
for folder in os.listdir('./data/train'):
    # print(folder)
    # print(path + '/' + folder + '/' + '*.')
    for extension in extensions:
        for img in glob.glob('./data/train' + '/' + folder + '/' + '*.' + extension):
            imgs.append(img)
            labels.append(1 if folder == 'hotdog' else 0)

random_seed = 42
X_train, X_test, y_train, y_test = train_test_split(imgs, labels, test_size=0.1, random_state=random_seed)
# print(X_train)
# print(X_test)
# print(y_train)
# print(y_test)
for data, label in zip(X_test, y_test):
    shutil.move(data, './data/test/hotdog') if label == 1 else shutil.move(data, './data/test/not_hotdog')