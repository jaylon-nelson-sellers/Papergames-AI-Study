import numpy as np
# apply transfer function
def _apply_transfer_function(self, x):
    if self.transfer_function == 'hard_limit':
        return np.where(x >= 0, 1, 0)
    elif self.transfer_function == 'hard_limits':
        return np.where(x >= 0, 1, -1)
    elif self.transfer_function == 'log_sigmoid':
        return 1 / (1 + np.exp(-x))
    elif self.transfer_function == 'relu':
        return np.maximum(0, x)
    elif self.transfer_function == 'purelin':
        return x
    elif self.transfer_function == 'softmax':
        e_x = np.exp(x - np.max(x))
        return e_x / e_x.sum(axis=0)
    else:
        raise ValueError(f"Unknown transfer function type: {self.transfer_function}")