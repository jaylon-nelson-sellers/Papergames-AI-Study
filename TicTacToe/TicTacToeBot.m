classdef TicTacToeBot
    %TICTACTOEBOT Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Brain
        rating
        wins
        loses
        draws
        winrate
        Genus
        Species
        generation
    end

    methods
        function obj = TicTacToeBot()
            obj.Brain = PerceptronLayer(28, 2, "purelin");
            obj.rating = Elo(1000,10);
            obj.wins =0;
            obj.loses=0;
            obj.draws=0;
            obj.winrate=0;
            obj.generation=1;
            [obj.Genus, obj.Species] = generate_random_name();
           
        end

        function [row, col] = bot_move(obj, board, tag)
            failedAttempts = 0;
            while failedAttempts < 3
                inputArray = readGameState(board, tag, failedAttempts);
                output = obj.Brain.getPureLin(inputArray);
                row = output(1);
                col = output(2);
                if (~(checkValid(row) && checkValid(col)))
                    failedAttempts = failedAttempts + 1;

                elseif board(row, col) == 0
                    break;
                else
                    failedAttempts = failedAttempts + 1;
                end
            end
            if (failedAttempts == 3)
                % Choose a random empty spot
                [row, col] = find(board == 0);
                idx = randi(length(row));
                row = row(idx);
                col = col(idx);
            end
            %pause(.5);
        end

        function score = getScore(obj)
            score = obj.rating.score;
        end

        function obj = setScore(obj, Opponent, Result)
            obj.rating = obj.rating.updateRating(Opponent.rating,Result);
            if (Result == 1)
                obj.wins = obj.wins + 1;
            elseif (Result == .5)
                obj.draws = obj.draws + 1;
            else
                obj.loses = obj.loses + 1;
            end
            obj.winrate = round(((obj.wins)/(obj.wins+obj.loses+obj.draws)) * 100, 2);
        end

            function obj = evolve(obj)
                [obj.Genus, obj.Species] = changeName(obj.Genus, obj.Species);

            end

        end
    end

