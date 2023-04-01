function [weights_new, biases_new] = mutate(weights, biases, MR)
% MUTATE Randomly mutates weights and biases based on a specified mutation rate.

[wRows, wCols] = size(weights);
[bRows, bCols] = size(biases);

mutatedWeights = weights;
numOfMutations = randi(wRows*wCols);
indexes = randperm(wRows *wCols, numOfMutations);

for i = 1:numOfMutations
    % Convert the linear index to a row and column index
    [row, col] = ind2sub([wRows wCols], indexes(i));

    % Add a random value to the selected index
    mutatedWeights(row, col) = mutatedWeights(row, col) + -MR + (MR+MR).*rand();
end

mutatedBiases = biases;
numOfMutations = randi(bRows*bCols);
indexes = randperm(bRows *bCols, numOfMutations);

for i = 1:numOfMutations
    % Convert the linear index to a row and column index
    [row, col] = ind2sub([bRows bCols], indexes(i));

    % Add a random value to the selected index
    mutatedBiases(row, col) = mutatedBiases(row, col) + -MR + (MR+MR).*rand();
end

weights_new = mutatedWeights;
biases_new = mutatedBiases;


end



