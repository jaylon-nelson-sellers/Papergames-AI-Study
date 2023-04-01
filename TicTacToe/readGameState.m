function inputLayer = readGameState(board, tag, failedAttempts)
    inputLayer = zeros(1,28);
    playerX = find(board ~= 0 & board == tag);
    EnemyO = find(board ~= 0 & board ~= tag);
    Empty = find(board == 0);

    inputLayer(playerX) = 1;
    
    inputLayer(EnemyO+9) = 1;

    inputLayer(Empty+18) = 1;

  
    inputLayer(28) = failedAttempts;
end