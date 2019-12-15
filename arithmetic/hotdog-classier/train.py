import torch.optim as optim
# from torchvision.datasets import ImageFolder
import torchvision.transforms as transforms
from model import *
from myDataset import *

epochs = 10
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(device)

# 构建数据集合
train_transform = transforms.Compose([transforms.Resize((224, 224)),
                                      transforms.RandomRotation(degrees=(0, 180)),
                                      transforms.ToTensor()
                                      ])

myTrainDataset = myDataset('./data/train', transform=train_transform)
myTrainDataloader = DataLoader(myTrainDataset, batch_size=32, shuffle=True)

# net = net.to(device)
net.train()
# 正则化 优化损失显示会有一定问题
# regularization_loss = 0.0
# for param in net.parameters():
#     # regularization_loss += torch.sqrt(torch.sum(torch.pow(param, 2))) L2
#     regularization_loss += torch.sum(torch.abs(param))

criterion = nn.CrossEntropyLoss()
optimizer = optim.Adam(net.parameters(), lr=1e-4, betas=(0.0, 0.999), weight_decay=0.01)

running_loss = 0.0
counter = 0
total = 0
correct = 0
for epoch in range(epochs):

    for idx, data in enumerate(myTrainDataloader):
        image, label = data
        # running_loss = 0.0
        # cuda_image = image.to(device)
        # cuda_label = label.to(device)
        optimizer.zero_grad()
        # 正向传播，反向传播，参数更新
        outputs = net(image)
        _, predicted = torch.max(outputs, 1)
        total += label.size(0)
        correct += (predicted == label).sum().item()
        classify_loss = criterion(outputs, label)
        loss = classify_loss
        loss.backward(retain_graph=False)
        optimizer.step()

        # 打印状态信息
        running_loss += loss.item()
        # print(criterion.item())
        if counter % 10 == 9:  # 每10批次打印一次
             print('[%d, %5d] loss: %.3f accuracy: %.3f' %(epoch + 1, idx + 1, running_loss / 10, correct / total))
             running_loss = 0.0
             correct = 0
             total = 0

        counter += 1


torch.save(net.state_dict(), './checkpoint/NotHotdog.pth')

