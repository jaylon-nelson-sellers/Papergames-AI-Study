import numpy as np


def mutate(parameter, p, mutation_rate):
    """
    Function to mutate a 2D array with a given probability and mutation rate.

    Args:
        parameter (numpy.array): A 2D array.
        p (float): Probability of changing each element in parameter (a value between 0 and 1).
        mutation_rate (float): A scalar factor to scale the magnitude of the mutation.

    Returns:
        numpy.array: A 2D array with mutated values.
    """

    # Get the size of the input array
    m, n = parameter.shape

    # Make a copy of the input array
    return_parameter = parameter.copy()

    # Loop over each element in the array
    for i in range(m):
        for j in range(n):
            # Generate a random number between 0 and 1
            rand_num = np.random.rand()

            # If the random number is less than p, change the element
            if rand_num < p:
                # Change the element to a random value times the mutation rate
                mutation = (np.random.rand() - 0.5) * mutation_rate
                return_parameter[i, j] += mutation

    return return_parameter