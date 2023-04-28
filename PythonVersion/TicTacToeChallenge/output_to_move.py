import numpy as np


def output_to_move(output):
    """
    Select the output with the maximum value.

    Args:
        output (array): An array of outputs.

    Returns:
        move (int): The index of the maximum output value.
    """
    return np.argmax(output)
