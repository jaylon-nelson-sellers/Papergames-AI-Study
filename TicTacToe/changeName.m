function [str1, str2] = changeName(str1, str2)
% Changes two strings as described:
% - The first string is completely changed, in both characters and length.
% - The second string, only 1-3 characters are changed.

% Generate a random number between 1 and 3 to determine how many characters
% to change in str2
rand_num = rand();

% If the random number is less than p, change the element
if rand_num < .5
    num_changes =1;

    % Generate random indices for the characters to be changed in str2
    change_indices = randperm(length(str2), num_changes);

    % Change the selected characters in str2 to random lowercase letters
    for i = 1:num_changes
        str2(change_indices(i)) = char(randi([97,122],1,1));
    end
else

end


% Define the length range
min_length = 5;
max_length = 15;

% Generate the first word
word1_length = randi([min_length, max_length]);
str1 = char(randi([97, 122], 1, word1_length));

end