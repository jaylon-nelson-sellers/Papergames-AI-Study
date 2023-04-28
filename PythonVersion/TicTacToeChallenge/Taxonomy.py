import random
import string
from mutate_name import mutate_name

class Taxonomy:
    def __init__(self):
        # Initialize each variable with a random string of length between 5 and 10
        self.Domain = ''.join(random.choices(string.ascii_letters, k=random.randint(5, 10)))
        self.Kingdom = ''.join(random.choices(string.ascii_letters, k=random.randint(5, 10)))
        self.Phylum = ''.join(random.choices(string.ascii_letters, k=random.randint(5, 10)))
        self.Class = ''.join(random.choices(string.ascii_letters, k=random.randint(5, 10)))
        self.Order = ''.join(random.choices(string.ascii_letters, k=random.randint(5, 10)))
        self.Family = ''.join(random.choices(string.ascii_letters, k=random.randint(5, 10)))
        self.Genus = ''.join(random.choices(string.ascii_letters, k=random.randint(5, 10)))
        self.Species = ''.join(random.choices(string.ascii_letters, k=random.randint(5, 10)))

        # Initialize the hash variable with a random Base64 encoded string of length 10
        self.Hash = ''.join(random.choices(string.ascii_letters + string.digits + '+/', k=10))

        # Initialize the generation variable to 1
        self.generation = 1

    #Copy Constructor
    def copy(self, Tax):
        self = Tax
        self.mutate()

    def get_hash(self):
        """
        Get the current hash value.

        Returns:
            str: The current hash value.
        """
        return self.Hash

    def mutate(self):
        """
        Mutate the taxonomy variables and update the generation and hash.
        """
        # Increase the generation by 1
        self.generation += 1

        # Randomize the hash
        self.Hash = ''.join(random.choices(string.ascii_letters + string.digits + '+/', k=10))

        # Mutate the taxonomy variables using the mutateName function with decreasing mutation rates
        mutation_rate = 1
        MN = mutate_name
        self.Domain = MN(self.Domain, mutation_rate)
        mutation_rate *= 0.5
        self.Kingdom = MN(self.Kingdom, mutation_rate)
        mutation_rate *= 0.5
        self.Phylum = MN(self.Phylum, mutation_rate)
        mutation_rate *= 0.5
        self.Class = MN(self.Class, mutation_rate)
        mutation_rate *= 0.5
        self.Order = MN(self.Order, mutation_rate)
        mutation_rate *= 0.5
        self.Family = MN(self.Family, mutation_rate)
        mutation_rate *= 0.5
        self.Genus = MN(self.Genus, mutation_rate)
        mutation_rate *= 0.5
        self.Species = MN(self.Species, mutation_rate)
