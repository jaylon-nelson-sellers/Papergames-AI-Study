function children = breed(parent, num_children, mutationRate)
% Performs crossover between two parents to create a specified number of
% children using the average of the parents' weights and biases.

% Create the children's weights and biases as the average of the parents'
children_weights = (parent.Brain.weights);
children_biases = (parent.Brain.biases);

% Create a random number of children
for i = 1:num_children
    % Perturb the children's weights and biases by adding random noise
   

    children_weights = mutate(children_weights,.25, .25);
    children_weights = mutate(children_weights,.125, .5);
    child_weights = mutate(children_weights,.065, 1);
    
    children_biases = mutate(children_biases,.25, .25);
    children_biases = mutate(children_biases,.125, .5);
    child_biases = mutate(children_biases,.065, 1);

    % Create the child structure
    child = TicTacToeBot();
    child.Genus = parent.Genus;
    child.Species = parent.Species;
    child.generation = parent.generation + 1;
    child = child.evolve();
    child.Brain.weights = child_weights;
    child.Brain.biases = child_biases;
    % Add the child to the list of children
    children(i) = child;
end

end