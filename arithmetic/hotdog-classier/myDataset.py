from torch.utils.data import DataLoader, Dataset
import os
import glob
# from utils import *
from PIL import Image

class myDataset(Dataset):

    def __init__(self, path='./data/train', imgSize=224, transform=None):
        super(myDataset, self).__init__()
        self.transform = transform
        self.imgSize = imgSize
        self.imgs = []
        self.labels = []
        extensions = ['jpg', 'png', 'bmp', 'jpeg', 'gif']
        if os.path.isfile(path) and path.split('/')[-1].split('.')[-1] in extensions:
            self.imgs.append(path)
            self.labels.append('None')
        elif os.path.isdir(path):
            for folder in os.listdir(path):
                # print(folder)
                # print(path + '/' + folder + '/' + '*.')
                for extension in extensions:
                    for img in glob.glob(path + '/' + folder + '/' + '*.' + extension):
                        self.imgs.append(img)
                        self.labels.append(1 if folder == 'hotdog' else 0)

        # self.imgs.sort(key=lambda x: int(x.split('\\')[-1].split('.')[0]))
        # print(len(self.imgs))
        # print(len(self.labels))

    # resize only
    def __getitem__(self, index):
        # img = cv2.imread(self.imgs[index], cv2.IMREAD_COLOR)
        # img = cv2.resize(img, (self.imgSize, self.imgSize))
        img = Image.open(self.imgs[index]).convert('RGB')
        label = self.labels[index]
        if self.transform:
            img = self.transform(img)

        return img, label


    def __len__(self):
        return len(self.imgs)


if __name__ == '__main__':
    imgs = []
    labels = []
    extensions = ['jpg', 'png', 'bmp', 'jpeg', 'gif']
    path = './data/train/hotdog/42.jpg'
    if os.path.isfile(path) and path.split('/')[-1].split('.')[-1] in extensions:
        imgs.append(path)
        labels.append('None')
    elif os.path.isdir(path):
        for folder in os.listdir(path):
            # print(folder)
            # print(path + '/' + folder + '/' + '*.')
            for extension in extensions:
                for img in glob.glob(path + '/' + folder + '/' + '*.' + extension):
                    imgs.append(img)
                    labels.append(1 if folder == 'hotdog' else 0)

    print(len(imgs))
    print(imgs)
    # for img in imgs:
    #     try:
    #         img_array = cv2.imread(img, cv2.IMREAD_COLOR)
    #         cv2.imwrite(img, img_array)
    #     except:
    #         os.remove(img)


