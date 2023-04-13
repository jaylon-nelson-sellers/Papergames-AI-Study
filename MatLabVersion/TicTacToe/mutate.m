function returnParameter = mutate(parameter, p, mutationRate)
% Function to mutate a 2D array with a given probability and mutation rate
% Input:
%   A: a 2D array
%   p: probability of changing each element in A (a value between 0 and 1)
%   mutationRate: a scalar factor to scale the magnitude of the mutation
% Output:
%   B: a 2D array with mutated values

% Get the size of the input array
[m, n] = size(parameter);

% Make a copy of the input array
returnParameter = parameter;

% Loop over each element in the array
for i = 1:m
    for j = 1:n
        % Generate a random number between 0 and 1
        rand_num = rand();
        
        % If the random number is less than p, change the element
        if rand_num < p
            % Change the element to a random value times the mutation rate
            mutation = ((rand() - 0.5) * mutationRate);
            returnParameter(i, j) = returnParameter(i, j) +mutation;
        end
    end
end
end