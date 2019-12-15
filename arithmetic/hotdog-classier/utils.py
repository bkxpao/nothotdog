import cv2
import numpy as np
from skimage import exposure

def rotateImage(img, angle):
    (rows, cols, ch) = img.shape
    M = cv2.getRotationMatrix2D((cols/2, rows/2), angle, 1)
    return cv2.warpAffine(img, M, (cols, rows))

# 随机旋转加模糊
def loadBlurImg(path, imgSize):
    img = cv2.imread(path)
    angle = np.random.randint(-180, 180)
    img = rotateImage(img, angle)
    img = cv2.blur(img, (5, 5))
    img = cv2.resize(img, imgSize)
    return img


def toGray(images):
    # rgb2gray converts RGB values to grayscale values by forming a weighted sum of the R, G, and B components:
    # 0.2989 * R + 0.5870 * G + 0.1140 * B
    # source: https://www.mathworks.com/help/matlab/ref/rgb2gray.html

    images = 0.2989 * images[:, :, :, 0] + 0.5870 * images[:, :, :, 1] + 0.1140 * images[:, :, :, 2]
    return images


def normalizeImages(images):
    # use Histogram equalization to get a better range
    # source http://scikit-image.org/docs/dev/api/skimage.exposure.html#skimage.exposure.equalize_hist
    images = (images / 255.).astype(np.float32)

    for i in range(images.shape[0]):
        images[i] = exposure.equalize_hist(images[i])

    images = images.reshape(images.shape + (1,))
    return images


def preprocessData(images):
    grayImages = toGray(images)
    return normalizeImages(grayImages)
