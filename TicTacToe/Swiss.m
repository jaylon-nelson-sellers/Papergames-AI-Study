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
            obj.rankings = zeros(size(obj.players));
            obj = obj.sort();
        end


        function obj = sort(obj)
            [~, idx] = sort(obj.rankings, 'descend');
            obj.players = obj.players(idx);
            obj.rankings = obj.rankings(idx);
        end

        % Method to run the tournament
        function returnVal = runSeason(obj)
            for iRound = 1:obj.numRounds
                % Pair players for this round
                pairings = obj.pairPlayers();

                % Play each game and update rankings
                for iGame = 1:size(pairings, 1)
                    rand_num = rand();
                    if rand_num < .5
                         p1 = pairings(iGame, 1);
                        p2 = pairings(iGame, 2);
                    else 
                        p1 = pairings(iGame, 2);
                        p2 = pairings(iGame, 1);
                    end
                   
                    winner = obj.playGame(obj.players(p1), obj.players(p2));
                    obj = obj.updateRankings(p1, p2, winner);

                    winner = obj.playGame(obj.players(p2), obj.players(p1));
                    obj = obj.updateRankings(p2, p1, winner);
                end

                % Display current rankings
                %disp(['Rankings after round ' num2str(iRound) ':']);
                obj = obj.sort();
                %disp(obj.rankings);
            end
            returnVal = obj.returnBestBots(.9);
        end

         % Method to run the tournament
         function returnVal = runTournament(obj)
            for iRound = 1:obj.numRounds
                % Pair players for this round
                pairings = obj.pairPlayers();

                % Play each game and update rankings
                for iGame = 1:size(pairings, 1)
                    rand_num = rand();
                    if rand_num < .5
                         p1 = pairings(iGame, 1);
                        p2 = pairings(iGame, 2);
                    else 
                        p1 = pairings(iGame, 2);
                        p2 = pairings(iGame, 1);
                    end
                   
                    winner = obj.playGame(obj.players(p1), obj.players(p2));
                    obj = obj.updateRankings(p1, p2, winner);

                    winner = obj.playGame(obj.players(p2), obj.players(p1));
                    obj = obj.updateRankings(p2, p1, winner);
                end

                % Display current rankings
                %disp(['Rankings after round ' num2str(iRound) ':']);
                obj = obj.sort();
                %disp(obj.rankings);
            end
            returnVal = obj.returnNumOfBots(10000);
         end

        % Method to pair players for a round based on current rankings
        function pairings = pairPlayers(obj)
            obj.sort();
            sortPlayers = obj.players;
            % Pair players with closest rankings
            numOfPairs = floor(length(sortPlayers)/2);
            pairings = zeros(numOfPairs, 2);
           
            for iPair = 1:size(pairings, 1)
                idx1 = (iPair-1)*2 + 1;
                idx2 = idx1 + 1;
                pairings(iPair, :) = [idx1 idx2];
            end
        end


        % Method to simulate a game between two players and return the winner
        function winner = playGame(~,player1, player2)
            game = TicTacToe();
            winner = game.playBotBotGame(player1,player2);
        end

        % Method to update player rankings after a round
        function obj = updateRankings(obj, P1Idx, P2Idx, W)
            P1 =  obj.players(P1Idx);
            P2 = obj.players(P2Idx);

            % Update rankings based on game outcome
            if W == 1
                obj.rankings(P1Idx) = obj.rankings(P1Idx) + 1;
                P1 = P1.setScore(P2.rating, 1);
                P2= P2.setScore(P1.rating, 0);
            elseif W == 2
                obj.rankings(P2Idx) = obj.rankings(P2Idx) + 1;
                P2 = P2.setScore(P1.rating, 1);
                P1 = P1.setScore(P2.rating, 0);
            else
                % Tie - do nothing
                P1 = P1.setScore(P2.rating, .5);
                P2 = P2.setScore(P1.rating, .5);
            end
            obj.players(P1Idx) = P1;
            obj.players(P2Idx) = P2;
        end

        function TopBots = returnBestBots(obj, percentile)
            sz = length(obj.players);
            NumOfBots = round(sz * (1-percentile));
            NumOfBots = round(NumOfBots,2);
            TopBots = TicTacToeBot.empty(NumOfBots, 0);

            j = 1;
            for i = 1:NumOfBots
                TopBots(i) = obj.players(i);
               
            end
        end

        function TopBots = returnNumOfBots(obj, num)
            TopBots = TicTacToeBot.empty(num, 0);

            for i = 1:num
                TopBots(i) = obj.players(i);               
            end
        end
    end
end