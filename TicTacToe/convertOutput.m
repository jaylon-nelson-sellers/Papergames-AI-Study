function [row_idx, col_idx] = convertOutput(in_array)
% Converts a 1x9 array into a 3x3 array and finds the row and column indices of the element with the value 1

out_array =  reshape(in_array', [3, 3])';

% Find the row and column indices of the element with the value 1
[row_idx, col_idx] = find(out_array == 1);

end