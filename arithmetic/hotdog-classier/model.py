from torchvision.models import resnet18
import torch.nn as nn
import torch


class Flatten(nn.Module):
    def __init__(self):
        super(Flatten, self).__init__()

    def forward(self, x):
        shape = torch.prod(torch.tensor(x.shape[1:])).item()
        return x.view(-1, shape)

# transfer model
net = nn.Sequential(*list(resnet18(pretrained=True).children())[:-1],
                      Flatten(),
                      nn.Linear(512, 240),
                      nn.Dropout(),
                      nn.ReLU(),
                      nn.Linear(240, 120),
                      nn.Dropout(),
                      nn.ReLU(),
                      nn.Linear(120, 2))

# rint(net)
# inp = torch.randn(1, 3, 64, 64)
# print(net(inp).shape)


