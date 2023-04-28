import numpy as np


# apply transfer function
def apply_transfer_function(x, tf):
    if tf == 'hard_limit':
        return np.where(x >= 0, 1, 0)
    elif tf == 'hard_limits':
        return np.where(x >= 0, 1, -1)
    elif tf == 'log_sigmoid':
        return 1 / (1 + np.exp(-x))
    elif tf == 'relu':
        return np.maximum(0, x)
    elif tf == 'purelin':
        return x
    elif tf == 'softmax':
        e_x = np.exp(x - np.max(x))
        return e_x / e_x.sum(axis=0)
    else:
        raise ValueError(f"Unknown transfer function type: {tf}")
