import mutate as mutate_module


def apply_progressive_mutations(child, initial_mutation_rate):
    """
    Apply a series of mutations to the child with progressively decreasing mutation probabilities
    and increasing mutation rates.

    Args:
        child: The child to be mutated.
        initial_mutation_rate (float): The initial mutation rate.

    Returns:
        mutated_child: The mutated child after applying progressive mutations.
    """

    mutation_probability = initial_mutation_rate
    mutation_rate = initial_mutation_rate

    for _ in range(5):
        mutated_child = mutate_module.mutate(child, mutation_probability, mutation_rate)
        mutation_probability /= 2
        mutation_rate *= 2

    return mutated_child
