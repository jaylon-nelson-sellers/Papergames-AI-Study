% Neuron Function
% @param inputs: a vector of inputs to be used in computation
% @param weights: a matrix of weights to be multiplied by the inputs
% @param bias: a vector of values to be added to each output
% @return Output: a vector or scalar of outputs based on the above values
% General Algorithm: The inputs multiply by the weights to get the temporary
% value of the outputs (for each Neuron)
% Then bias is added to each
function Output = Neuron(inputs, weights, bias)
Output = (inputs * weights') + bias;

end