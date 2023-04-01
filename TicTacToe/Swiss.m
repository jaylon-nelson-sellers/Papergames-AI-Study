classdef Swiss
    % Class for a Swiss-system tournament
    properties
        players  % Array of player names
        numRounds  % Number of rounds to play
        rankings  % Array to hold current player rankings
    end

    methods
        % Constructor method
        function obj = Swiss(playerArray, numRounds)
            obj.players = playerArray;
            obj.numRounds = numRounds;
            obj = obj.sort();
        end


        function obj = sort(obj)
            scores = nan(size(obj.players));
            for ii = 1:numel(obj.players)
                scores(ii) = obj.players(ii).Score.score;
            end
            [~, idx] = sort(scores, 'descend');
            obj.players = obj.players(idx);
            for i = 1:numel(obj.players)
                obj.rankings(i) = obj.players(i).Score.score;
            end
        end

        % Method to run the tournament
        function returnVal = runTournament(obj)
            for iRound = 1:obj.numRounds
                % Pair players for this round
                pairings = obj.pairPlayers();

                % Play each game and update rankings
                for iGame = 1:size(pairings, 1)
                    player1 = pairings(iGame, 1);
                    player2 = pairings(iGame, 2);
                    winner = obj.playGame(player1, player2);
                    obj.updateRankings(player1, player2, winner);
                end

                % Display current rankings
                disp(['Rankings after round ' num2str(iRound) ':']);
                disp(obj.rankings);
            end

            returnVal = obj.returnBestBots(.75);
        end

        % Method to pair players for a round based on current rankings
        function pairings = pairPlayers(obj)
            % Shuffle players to randomize pairings
            shuffledPlayers = obj.players(randperm(length(obj.players)));

            % Pair players with closest rankings
            pairings = zeros(length(shuffledPlayers)/2, 2);
            for iPair = 1:size(pairings, 1)
                idx1 = (iPair-1)*2 + 1;
                idx2 = idx1 + 1;
                pairings(iPair, :) = [shuffledPlayers(idx1) shuffledPlayers(idx2)];
            end
        end

        % Method to simulate a game between two players and return the winner
        function winner = playGame(obj, player1, player2)
            game = TicTacToe();
            winnerIdx = game.playBotBotGame(player1,player2);
            if winnerIdx == 1
                winner = player1;
            else
                winner = player2;
            end
        end

        % Method to update player rankings after a round
        function obj = updateRankings(obj, player1, player2, winner)
            % Find indices of players in rankings array
            idx1 = find(strcmp(obj.players, player1));
            idx2 = find(strcmp(obj.players, player2));
            winIdx = find(strcmp(obj.players, winner));

            % Update rankings based on game outcome
            if winIdx == idx1
                obj.rankings(idx1) = obj.rankings(idx1) + 1;
            elseif winIdx == idx2
                obj.rankings(idx2) = obj.rankings(idx2) + 1;
            else
                % Tie - do nothing
            end
        end

        function TopBots = returnBestBots(obj, percentile)
            sz = Size(obj.players);
            NumOfBots = round(sz * (1-percentile));
            Range = sz- NumOfBots;
            TopBots = repmat(TicTacToeBot(), NumOfBots, 1);
            j = 0;
            for i = sz:-1:Range
                TopBots(j) = obj.players(i);
                j = j + 1;
            end
        end
    end
end