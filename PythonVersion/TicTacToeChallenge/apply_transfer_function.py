import numpy as np


def apply_transfer_function(input_value, transfer_function):
    """
    Apply the specified transfer function to the input value.

    Args:
        input_value: The input value to apply the transfer function to.
        transfer_function: The transfer function to apply ('hard_limit', 'hard_limits', 'log_sigmoid',
                           'relu', 'purelin', or 'softmax').

    Returns:
        The result of applying the transfer function to the input value.

    Raises:
        ValueError: If an unknown transfer function type is provided.
    """
    if transfer_function == 'hard_limit':
        return np.where(input_value >= 0, 1, 0)
    elif transfer_function == 'hard_limits':
        return np.where(input_value >= 0, 1, -1)
    elif transfer_function == 'log_sigmoid':
        return 1 / (1 + np.exp(-input_value))
    elif transfer_function == 'relu':
        return np.maximum(0, input_value)
    elif transfer_function == 'purelin':
        return input_value
    elif transfer_function == 'softmax':
        exp_input = np.exp(input_value - np.max(input_value))
        return exp_input / exp_input.sum(axis=0)
    else:
        raise ValueError(f"Unknown transfer function type: {transfer_function}")
