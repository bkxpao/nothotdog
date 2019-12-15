from metrics import *
from model import *
from myDataset import *
import torchvision.transforms as transforms
import numpy as np

















device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
# 测试代码
net.to(device)
net.load_state_dict(torch.load('./checkpoint/NotHotdog.pth'))
net.eval()

test_transform = transforms.Compose([transforms.Resize((224, 224)),
                                     transforms.ToTensor()])
myTestDataset = myDataset('./data/test', transform=test_transform)
myTestDataloader = DataLoader(myTestDataset, batch_size=1, shuffle=False)




total = 0
correct = 0
true_labels = []
pred_labels = []
print('waiting...')
with torch.no_grad():
    for idx, data in enumerate(myTestDataloader):
        image, label = data
        true_labels.append(label.item())
        cuda_image = image.to(device)
        cuda_label = label.to(device)
        outputs = net(cuda_image)
        _, predicted = torch.max(outputs, 1)
        pred_labels.append(predicted.cpu().item())
        total += cuda_label.size(0)
        correct += (predicted == cuda_label).sum().item()

print(true_labels)
print(pred_labels)


print('Accuracy of the network on the total test images: %d %%' % (100 * correct / total))
recall, precision, f1_score = confusion_mat(np.array(true_labels), np.array(pred_labels))
print(recall, precision, f1_score)
print(np.array(myTestDataset.imgs)[np.array(true_labels) != np.array(pred_labels)])