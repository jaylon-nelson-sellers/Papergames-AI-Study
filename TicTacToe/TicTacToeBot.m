classdef TicTacToeBot
    %TICTACTOEBOT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Brain
    end
    
    methods
        function obj = TicTacToeBot()
            obj.Brain = PerceptronLayer(100, 10,"hardlim");
        end

        function [row, col] = bot_move(obj, board)
            % Choose a random empty spot
            [row, col] = find(board == 0);
            idx = randi(length(row));
            row = row(idx);
            col = col(idx);
        end
    end
end

