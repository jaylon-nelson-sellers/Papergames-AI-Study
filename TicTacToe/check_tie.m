function tie = check_tie(board)
% Check if the game is a tie
tie = all(board(:) ~= 0);
end