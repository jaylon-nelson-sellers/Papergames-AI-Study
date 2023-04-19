import random
import string

def MutateName(id, mutate_rate):
    """
    Mutate the given string "id" based on the "mutate_rate" provided.

    Args:
        id (str): The original string to be mutated.
        mutate_rate (float): The mutation rate (between 0 and 1) determining the chance of each character being mutated.

    Returns:
        str: The mutated string.
    """
    mutated_id = ""

    # Iterate through the characters in the original string
    for char in id:
        # Generate a random number between 0 and 1
        random_number = random.random()

        # If the random number is less than the mutation rate, mutate the character
        if random_number < mutate_rate:
            # Choose a random letter from the alphabet
            mutated_char = random.choice(string.ascii_letters)
        else:
            # Keep the original character
            mutated_char = char

        # Append the mutated/original character to the mutated_id
        mutated_id += mutated_char

    # Return the mutated id
    return mutated_id
