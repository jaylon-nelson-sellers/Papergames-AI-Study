import random
import string

def mutate_name(name, mutation_rate):
    """
    Mutate the given string "name" based on the "mutation_rate" provided.

    Args:
        name (str): The original string to be mutated.
        mutation_rate (float): The mutation rate (between 0 and 1) determining the chance of each character being mutated.

    Returns:
        str: The mutated string.
    """
    mutated_name = ""

    # Iterate through the characters in the original string
    for char in name:
        # Generate a random number between 0 and 1
        random_number = random.random()

        # If the random number is less than the mutation rate, mutate the character
        if random_number < mutation_rate:
            # Choose a random letter from the alphabet
            mutated_char = random.choice(string.ascii_letters)
        else:
            # Keep the original character
            mutated_char = char

        # Append the mutated/original character to the mutated_name
        mutated_name += mutated_char

    # Return the mutated name
    return mutated_name