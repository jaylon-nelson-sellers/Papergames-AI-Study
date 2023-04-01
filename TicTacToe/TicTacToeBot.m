classdef TicTacToeBot
    %TICTACTOEBOT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Brain
        Score
    end
    
    methods
        function obj = TicTacToeBot()
            obj.Brain = PerceptronLayer(100, 10,"hardlim");
            obj.Score = Glicko2Score(1500, 350, 0.06, .75)
        end

        function [row, col] = bot_move(obj, board)
            pause(2);

            % Choose a random empty spot
            [row, col] = find(board == 0);
            idx = randi(length(row));
            row = row(idx);
            col = col(idx);
        end
    end
end

