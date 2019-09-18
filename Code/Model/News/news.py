import numpy as np

def run_news(X, threshold=7):
    """calculate national early warning score and get predictions
    :param X: numpy array, shape(n_samples, 7)
              training array, where n_samples is the number of samples and the 7 columns are
              respiratory rate, spo2, supplemental oxygen, systolic bp, pulse, temperature, level of consciousness
    :param threshold: integer, range [0, 21], default=7
                      threshold used to generate alert
    :return scores: numpy array, shape(n_samples)
                    news scores for samples in X
    :return labels: numpy array, shape(n_samples)
                    class labels for samples in X
    """
    def func(x):
        """
        :param x: numpy array, shape(7)
        :return: news score for one sample
        """
        score = 0
        # respiratory rate
        if x[0] <= 8: score += 3
        elif x[0] <= 11: score += 1
        elif (x[0] >=21) and (x[0] <= 24): score += 2
        elif x[0] >24: score += 3
        # spo2
        if x[1] <= 91: score += 3
        elif x[1] <= 93: score += 2
        elif x[1] < 96: score += 1
        # supplemental oxygen
        if x[2] == 1: score += 2
        # systolic bp
        if x[3] <= 90: score += 3
        elif x[3] <= 100: score += 2
        elif x[3] <= 110: score += 1
        elif x[3] >= 220: score += 3
        # pulse
        if x[4] <= 40: score += 3
        elif x[4] <=50: score += 1
        elif (x[4] > 90) and (x[4] <= 110): score += 1
        elif (x[4] > 110) and (x[4] <= 130): score += 2
        elif x[4] > 130: score += 3
        # temperature
        if x[5] <= 35: score += 3
        elif x[5] <= 36: score += 1
        elif (x[5] > 38) and (x[5] <=39): score += 1
        elif x[5] > 39: score += 2
        # level of consciousness
        if x[6] == 1: score += 3
        return score

    scores = np.apply_along_axis(func, 1, X)
    labels = scores.copy()
    labels[labels < threshold] = 0
    labels[labels >= threshold] = 1
    return scores, labels