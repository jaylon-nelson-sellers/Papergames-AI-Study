function children = breed(parent, num_children, mutationRate)
% Performs crossover between two parents to create a specified number of
% children using the average of the parents' weights and biases.

% Create the children's weights and biases as the average of the parents'
children_weights = (parent.Brain.weights) / 2;
children_biases = (parent.Brain.biases) / 2;

% Create a random number of children
for i = 1:num_children
    % Perturb the children's weights and biases by adding random noise
   

    children_weights = mutate(children_weights,.3, 2);
    children_weights = mutate(children_weights,.1, 4);
    child_weights = mutate(children_weights,.05, 8);
    
    children_biases = mutate(children_biases,.3, 2);
    children_biases = mutate(children_biases,.1, 4);
    child_biases = mutate(children_biases,.05, 8);

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