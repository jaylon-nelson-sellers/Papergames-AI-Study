import numpy as np


def mutate_weights(weights, mutation_probability, mutation_rate):
    """
    Mutate a 2D array (weights) with a given probability and mutation rate.

    Args:
        weights (numpy.array): A 2D array representing the weights to be mutated.
        mutation_probability (float): Probability of changing each element in weights (between 0 and 1).
        mutation_rate (float): A scalar factor to scale the magnitude of the mutation.

    Returns:
        numpy.array: A 2D array with mutated weights.
    """

    # Get the dimensions of the input weights array
    num_rows, num_columns = weights.shape

    # Make a copy of the input weights array
    mutated_weights = weights.copy()

    # Iterate over each element in the weights array
    for row in range(num_rows):
        for column in range(num_columns):
            # Generate a random number between 0 and 1
            random_number = np.random.rand()

            # If the random number is less than the mutation_probability, mutate the weight
            if random_number < mutation_probability:
                # Calculate the mutation and update the weight
                mutation = (np.random.rand() - 0.5) * mutation_rate
                mutated_weights[row, column] += mutation

    return mutated_weights
