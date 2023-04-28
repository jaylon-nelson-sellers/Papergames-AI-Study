import numpy as np
import apply_transfer_function as atf
import mutate_child as mc

class SingleLayerPerceptron:
    def __init__(self, transfer_function, num_inputs, num_outputs):
        self.transfer_function = transfer_function
        self.num_inputs = num_inputs
        self.num_outputs = num_outputs
        self.weights = np.random.randn(num_inputs, num_outputs)
        self.biases = np.random.randn(num_outputs)

    def forward(self, inputs):
        """
        Perform a forward pass through the single-layer perceptron.

        Args:
            inputs (array): An array of inputs.

        Returns:
            outputs (array): An array of outputs.
        """
        outputs = np.dot(inputs, self.weights) + self.biases
        outputs = atf.apply_transfer_function(outputs, self.transfer_function)
        return outputs

    def crossover_and_mutate(self, other_architecture):
        """
        Perform crossover with another single-layer perceptron architecture and mutate the child architecture.

        Args:
            other_architecture (SingleLayerPerceptron): Another single-layer perceptron architecture.

        Returns:
            child_architecture (SingleLayerPerceptron): A child single-layer perceptron architecture.
        """
        child_architecture = SingleLayerPerceptron(self.transfer_function, self.num_inputs, self.num_outputs)

        # Crossover weights
        for i in range(self.num_inputs):
            for j in range(self.num_outputs):
                if np.random.rand() < 0.5:
                    child_architecture.weights[i, j] = self.weights[i, j]
                else:
                    child_architecture.weights[i, j] = other_architecture.weights[i, j]

        # Crossover biases
        for i in range(self.num_outputs):
            if np.random.rand() < 0.5:
                child_architecture.biases[i] = self.biases[i]
            else:
                child_architecture.biases[i] = other_architecture.biases[i]

        # Mutate child architecture
        child_architecture = mc.mutate_child(child_architecture, 0.5)

        return child_architecture
