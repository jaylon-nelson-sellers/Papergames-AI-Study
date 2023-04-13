function win = check_win(board, player)
% Check if the player has won
win = false;

% Check rows
if any(all(board == repmat(player, 3, 1), 2))
    win = true;
    return;
end

% Check columns
if any(all(board == repmat(player, 1, 3), 1))
    win = true;
    return;
end

% Check diagonals
if all(diag(board) == player) || all(diag(fliplr(board)) == player)
    win = true;
    return;
end
end