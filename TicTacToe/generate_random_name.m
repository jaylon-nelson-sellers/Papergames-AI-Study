function [genus, species] = generate_random_name()
% GENERATE_RANDOM_WORDS Generate two random words with lengths between 3 and 10 characters.

% Define the length range
min_length = 5;
max_length = 15;

% Generate the first word
word1_length = randi([min_length, max_length]);
genus = char(randi([97, 122], 1, word1_length));

% Generate the second word
word2_length = randi([max_length, max_length]);
species = char(randi([97, 122], 1, word2_length));

end