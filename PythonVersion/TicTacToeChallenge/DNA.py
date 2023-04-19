import numpy as np

class DNA:
    #Constructor method
    def __init__(self, type, arch, TF):
        self.type = type
        self.architecture = arch
        self.transfer_function = TF

    def forward(self, inputs):
        """
        Perform a forward pass through the neural network.

        Args:
            inputs (array): An array of inputs.

        Returns:
            outputs (array): An array of outputs.
        """
        return self.architecture.forward(inputs)

    def rounded_output(self, outputs):
        """
        Round the outputs to the nearest integer.

        Args:
            outputs (array): An array of outputs.

        Returns:
            rounded_outputs (array): An array of rounded outputs.
        """
        return np.round(outputs).astype(int)

    def output_to_move(self, outputs):
        """
        Select the output with the maximum value.

        Args:
            outputs (array): An array of outputs.

        Returns:
            move (int): The index of the maximum output value.
        """
        return np.argmax(outputs)

    def crossover(self, other_bot, num_children):
        """
        Perform crossover with another bot to produce children.

        Args:
            other_bot (Bot): Another bot object.
            num_children (int): The number of children to produce.

        Returns:
            children (list): A list of children bot objects.
        """
        children = []
        for _ in range(num_children):
            child_dna = DNA()
            child_dna.architecture = self.architecture.crossover(other_bot.architecture)
            children.append(child_dna)

        return children

    def set_architecture(self, architecture):
        """
        Set the neural network architecture for the DNA object.

        Args:
            architecture (object): An object representing the neural network architecture.
        """
        self.architecture = architecture
