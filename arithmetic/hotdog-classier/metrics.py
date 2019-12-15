from sklearn.metrics import confusion_matrix

def confusion_mat(true_label, pred_label):
    matrix = confusion_matrix(y_true=true_label, y_pred=pred_label)
    TN = matrix[0][0]
    FP = matrix[0][1]
    FN = matrix[1][0]
    TP = matrix[1][1]

    recall = TP / (TP + FN)
    precision = TP / (TP + FP)
    f1_score = 2 * recall * precision / (precision + recall)
    return recall, precision, f1_score

