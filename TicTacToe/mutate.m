function [weights_new, biases_new] = mutate(weights, biases, mutation_rate)
% MUTATE Randomly mutates weights and biases based on a specified mutation rate.

% Determine the number of weights and biases
num_weights = numel(weights);
num_biases = numel(biases);

% Generate a random matrix with the same dimensions as the weights
mutation_matrix = randn(num_weights, 1) < mutation_rate;

% Create the new weight and bias matrices
weights_new = weights + mutation_matrix .* randn(num_weights, 1);
biases_new = biases + mutation_matrix .* randn(num_biases, 1);

end



